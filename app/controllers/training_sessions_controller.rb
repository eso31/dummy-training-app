# frozen_string_literal: true
class TrainingSessionsController < ApplicationController
  load_and_authorize_resource

  include GoogleCalendar

  before_action :set_training_session, only: %i[show edit update destroy enrollment_users]

  # GET /training_sessions
  # GET /training_sessions.json
  def index
    if current_user.has_cached_role?(:workshops_admin) || current_user.has_cached_role?(:admin)
      if params[:q].blank?
        @training_sessions = TrainingSession.order(start_date: :desc).includes(:course, :class_location).page params[:page]
      else
        # TODO: we need to move this `import` call to an initializer or something similar
        # TrainingSession.import force: true
        @training_sessions = TrainingSession.search(params[:q]).page(params[:page]).records
      end
    else
      if params[:q].blank?
        @training_sessions = TrainingSession
                             .where(published: true)
                             .order(start_date: :desc)
                             .includes(:course, :class_location).page params[:page]
      else
        @training_sessions = TrainingSession.search(params[:q]).records.where(published: true).page(params[:page])
      end
    end
  end

  # GET /training_sessions/1
  # GET /training_sessions/1.json
  def show
    @user_enrollment = Enrollment.find_by(user: current_user,
                                          training_session: @training_session)

    # This variable is used on the General Ledger modal partial
    @general_ledger = GeneralLedger.new
    @session_rating = SessionRating
                      .find_or_initialize_by(user: current_user,
                                             enrollment: @user_enrollment)
  end

  # GET /enrollment_users
  def enrollment_users
    enrolled_users = @training_session.enrolled_and_instructors_ids

    @users = if params[:q].blank?
               User
             else
               User.search(params[:q]).records
             end.where.not(id: enrolled_users)
             .page params[:page]
  end

  # GET /training_sessions/new
  def new
    @training_session = TrainingSession.new
  end

  # GET /training_sessions/1/edit
  def edit; end

  # POST /training_sessions
  # POST /training_sessions.json
  def create
    @training_session = TrainingSession.new(training_session_params)
    respond_to do |format|
      if @training_session.valid?
        @training_session.google_calendar_event_id = create_event(
          start_date: @training_session.start_date,
          end_date: @training_session.end_date,
          summary: @training_session.summary )
        @training_session.google_calendar_id = ENV['CALENDAR_EMAIL']
        if @training_session.save
          format.html { redirect_to @training_session, notice: 'Training session was successfully created.' }
          format.json { render :show, status: :created, location: @training_session }
        else
          format.html { render :new }
          format.json { render json: @training_session.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @training_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /training_sessions/1
  # PATCH/PUT /training_sessions/1.json
  def update
    respond_to do |format|
      if @training_session.update(training_session_params)
        format.html { redirect_to @training_session, notice: 'Training session was successfully updated.' }
        format.json { render :show, status: :ok, location: @training_session }
      else
        format.html { render :edit }
        format.json { render json: @training_session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /training_sessions/1
  # DELETE /training_sessions/1.json
  def destroy
    @training_session.destroy
    respond_to do |format|
      format.html { redirect_to training_sessions_url, notice: 'Training session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_training_session
    @training_session = TrainingSession
                        .includes(:general_ledgers, :instructors,
                                  :class_location)
                        .includes(general_ledgers:
                                      %i[financial_account ledger_category])
                        .includes(enrollments: [
                                    { session_rating: :user },
                                    :user
                                  ])
                        .find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def training_session_params
    params.require(:training_session)
          .permit(:q, :title, :description, :min_group_size, :max_group_size,
                  :start_date, :url, :duration_in_minutes, :compensation,
                  :compensation_delivered, :session_type, :course_id,
                  :published, :class_location_id, instructor_ids: [], instructors_attributes: [:id])
  end
end
