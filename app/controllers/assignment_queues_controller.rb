# frozen_string_literal: true

class AssignmentQueuesController < ApplicationController
  load_and_authorize_resource

  before_action :set_assignment_queue, only: %i[show edit update destroy]

  # GET /assignment_queues
  # GET /assignment_queues.json
  def index
    if params[:q].blank?
      @assignment_queues = AssignmentQueue.order(id: :desc).includes(:user, :training_request).page params[:page]
    else
      @assignment_queues = AssignmentQueue.search(params[:q]).page(params[:page]).records
    end
  end

  # GET /assignment_queues/1
  # GET /assignment_queues/1.json
  def show; end

  # GET /assignment_queues/new
  def new
    @assignment_queue = AssignmentQueue.new
  end

  # GET /assignment_queues/1/edit
  def edit; end

  # POST /assignment_queues
  # POST /assignment_queues.json
  def create
    @assignment_queue = AssignmentQueue.new(assignment_queue_params)

    respond_to do |format|
      if @assignment_queue.save
        format.html { redirect_to @assignment_queue, notice: 'Assignment queue was successfully created.' }
        format.json { render :show, status: :created, location: @assignment_queue }
      else
        format.html { render :new }
        format.json { render json: @assignment_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignment_queues/1
  # PATCH/PUT /assignment_queues/1.json
  def update
    respond_to do |format|
      if @assignment_queue.update(assignment_queue_params)
        format.html { redirect_to @assignment_queue, notice: 'Assignment queue was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment_queue }
      else
        format.html { render :edit }
        format.json { render json: @assignment_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignment_queues/1
  # DELETE /assignment_queues/1.json
  def destroy
    @assignment_queue.destroy
    respond_to do |format|
      format.html { redirect_to assignment_queues_url, notice: 'Assignment queue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /assignment_round
  # POST /assignment_round.json
  def assignment_round
    AssignmentQueue.assignment_round

    respond_to do |format|
      format.html do
        flash[:notice] = 'New assignment round generated'
        redirect_to action: :index
      end
      format.json { redirect_to action: :index, status: :ok }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assignment_queue
    @assignment_queue = AssignmentQueue.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def assignment_queue_params
    params.require(:assignment_queue).permit(:assignment_order, :status, :user_id, :training_request_id)
  end
end
