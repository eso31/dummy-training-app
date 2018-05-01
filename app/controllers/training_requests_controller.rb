class TrainingRequestsController < ApplicationController

  load_and_authorize_resource

  include AdvancedSearchHelper

  before_action :set_training_request, only: %i[show edit update destroy add_requester destroy_requester]
  before_action :set_next_in_line, only: %i[new edit]

  # GET /training_requests
  # GET /training_requests.json
  def index
    @training_requests = if params[:q].blank?
                           TrainingRequest.order(start_date: :desc)
                                          .includes(:assigned_to_user, :requested_by_user)
                                          .page params[:page]
                         else
                           elastic_search_results(TrainingRequest)
                         end
  end

  # GET /training_requests/1
  # GET /training_requests/1.json
  def show
    @training_request_poll = TrainingRequestPoll.new
    @requester = Requester.new(training_request: @training_request)

    # Setup the general ledger entry for the modal
    @general_ledger = GeneralLedger.new
    @general_ledger.training_request = @training_request
  end

  # GET /training_requests/new
  def new
    @training_request = TrainingRequest.new
  end

  # GET /training_requests/1/edit
  def edit; end

  # POST /training_requests
  # POST /training_requests.json
  def create
    @training_request = TrainingRequest.new(check_training_request_params)
    respond_to do |format|
      if @training_request.save
        # After saving the TR create the requester
        assign_requester @training_request
        # After saving the TR update the assignment queue
        update_assignment_queue
        format.html {redirect_to @training_request, notice: 'Training request was successfully created.'}
        format.json {render :show, status: :created, location: @training_request}
      else
        format.html {render :new}
        format.json {render json: @training_request.errors, status: :unprocessable_entity}
      end
    end
  end

  def add_requester
    @requester = Requester.new(requester_params)
    @requester.status = @training_request.status
    if @requester.save
      redirect_to @training_request, notice: 'Requester was successfully created.'
    else
      render :show
    end
  end

  def update_requester_status
    respond_to do |format|
      format.js do
        @requester = Requester.find(params[:requester_id])
        @requester.status = params[:status]
        render js: @requester.errors unless @requester.save
      end
      format.all {render status: 404}
    end
  end

  def destroy_requester
    @requester = Requester.find(params[:requester_id])
    @requester.destroy
    redirect_to @training_request, notice: 'Requester was successfully deleted.'
  end

  # PATCH/PUT /training_requests/1
  # PATCH/PUT /training_requests/1.json
  def update
    respond_to do |format|
      if @training_request.update(training_request_params)
        format.html {redirect_to @training_request, notice: 'Training request was successfully updated.'}
        format.json {render :show, status: :ok, location: @training_request}
      else
        format.html {render :edit}
        format.json {render json: @training_request.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /training_requests/1
  # DELETE /training_requests/1.json
  def destroy
    @training_request.destroy
    respond_to do |format|
      format.html {redirect_to training_requests_url, notice: 'Training request was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def check_training_request_params
    if current_user.has_cached_role? :admin
      add_training_admin_to_params
    else
      add_training_admin_to_params.merge(requested_by_user: current_user, status: :pending_review)
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_training_request
    @training_request = TrainingRequest.includes(:assigned_to_user, :requested_by_user, :general_ledgers).find(params[:id])
  end

  def set_next_in_line
    @users = AssignmentQueue.queue.map(&:user)
  end

  def assign_requester(training_request)
    if current_user.has_role? :admin
      Requester.create training_request: training_request, user: training_request.requested_by_user, status: :pending_review unless training_request.requested_by_user.blank?
    else
      Requester.create training_request: training_request, user: current_user, status: :pending_review
    end
  end

  def training_request_params
    params.require(:training_request).permit(:name, :description, :location, :duration_in_minutes, :start_date, :end_date, :status, :reference_file, :assigned_to_user_id, :requested_by_user_id)
  end

  # Get the correct params to create the training request
  # and set automatically the training admin assigned if the request
  # is made by a user, otherwise use the training admin from params
  def add_training_admin_to_params
    current_user.has_role?(:admin) ? training_request_params : merge_next_ta_in_queue
  end

  # Merge the user id of the next user in the queue to the
  # training request params
  def merge_next_ta_in_queue
    AssignmentQueue.assignment_round if AssignmentQueue.queue.empty?
    training_request_params.merge('assigned_to_user_id' => AssignmentQueue.next_in_queue.user_id)
  end

  # After the training request is created, this method update the assignment
  # queue status for the selected training admin
  def update_assignment_queue
    return unless @training_request&.assigned_to_user_id

    # Find the queue entry for the user in the queue
    queue_entry = AssignmentQueue.queue.detect do |q|
      q.user_id == @training_request.assigned_to_user_id
    end

    AssignmentQueue
      .update(queue_entry.id, status: 'ASSIGNED',
                              training_request_id: @training_request.id)
  end

  # Accepted params for elasticsearch
  def q_params
    params.require(:q)
          .permit(:requested_by_user_id, :assigned_to_user_id, :status,
                  created_at: %i[start_date end_date])
  end

  def requester_params
    params.require(:requester).permit(:user_id, :training_request_id, :status)
  end
end


