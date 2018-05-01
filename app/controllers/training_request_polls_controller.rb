class TrainingRequestPollsController < ApplicationController
  load_and_authorize_resource
  before_action :set_training_request_poll, only: [:show, :edit, :update, :destroy, :update_vote]
  before_action :set_training_request

  # GET /training_request_polls
  # GET /training_request_polls.json
  def index
    @training_request_polls = TrainingRequestPoll.order(:id).page params[:page]
  end

  # GET /training_request_polls/1
  # GET /training_request_polls/1.json
  def show; end

  # GET /training_request_polls/new
  def new
    @training_request_poll = TrainingRequestPoll.new
  end

  # GET /training_request_polls/1/edit
  def edit; end

  # POST /training_request_polls
  # POST /training_request_polls.json
  def create
    @training_request_poll = TrainingRequestPoll.new(training_request_poll_params.merge({user: current_user, training_request: @training_request}))
    respond_to do |format|
      if @training_request_poll.save
        format.html { redirect_to @training_request, notice: 'The vote was successfully registered.' }
        format.json { render :show, status: :created, location: @training_request_poll }
      else
        format.html { redirect_to @training_request, notice: @training_request_poll.errors.full_messages.join(". ") }
        format.json { render json: @training_request_poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_request_polls/1
  # PATCH/PUT /training_request_polls/1.json
  def update
    respond_to do |format|
      if @training_request_poll.update(training_request_poll_params)
        format.html { redirect_to @training_request, notice: 'Training request poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @training_request_poll }
      else
        format.html { redirect_to @training_request, notice: @training_request_poll.errors.full_messages.join(". ") }
        format.json { render json: @training_request_poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_request_polls/1
  # DELETE /training_request_polls/1.json
  def destroy
    @training_request_poll.destroy
    respond_to do |format|
      format.html { redirect_to @training_request, notice: 'Training request poll was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /training_request/1/vote/1
  def update_vote
    respond_to do |format|
      format.js do
        if @training_request_poll.update(vote: params[:vote])
          render json: @training_request.vote_count, content_type: :json
        else
          render js: @training_request_poll.errors, status: :unprocessable_entity
        end
      end
      format.all { render status: 404 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_training_request_poll
      @training_request_poll = TrainingRequestPoll.find(params[:id])
    end

    def set_training_request
      @training_request = TrainingRequest.find(params[:training_request_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def training_request_poll_params
      params.require(:training_request_poll).permit(:vote, :comment, :training_request_id, :user_id)
    end
end
