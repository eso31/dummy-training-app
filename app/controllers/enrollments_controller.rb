class EnrollmentsController < ApplicationController

  load_and_authorize_resource

  before_action :set_enrollment, only: %i[update destroy]

  include GoogleCalendar

  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollments = Enrollment.order(created_at: :desc).page params[:page]
  end

  # POST /enrollments
  # POST /enrollments.json
  def create

    @training_session = TrainingSession.find enrollment_params[:training_session_id]
    if @training_session.full?
      respond_to do |format|
        format.html {redirect_to @training_session, notice: 'This training session is already full'}
        format.json {render @training_session, notice: 'This training session is already full'}
      end
    else
      @enrollment = Enrollment.new(enrollment_params)
      respond_to do |format|
        if @enrollment.valid?
          add_attendee(event_id: @enrollment.training_session.google_calendar_event_id, attendee: Google::Apis::CalendarV3::EventAttendee.new(email: @enrollment.user.email))
          if @enrollment.save
            format.html { redirect_to @enrollment.training_session, notice: 'Enrollment Successful' }
            format.json { render @enrollment.training_session, status: :created, location: @training_session }
          else
            format.html { redirect_to training_sessions_path, notice: @enrollment.errors}
            format.json { render json: @enrollment.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to training_sessions_path, notice: @enrollment.errors}
          format.json { render json: @enrollment.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(attended: @enrollment.set_attended)
        format.html { redirect_to @enrollment.training_session }
        format.json { render :show, status: :ok, location: @enrollment }
        format.js
      else
        format.html { redirect_to training_sessions_path, notice: @enrollment.errors }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    if @enrollment.destroy
      remove_attendee(event_id: @enrollment.training_session.google_calendar_event_id, attendee: Google::Apis::CalendarV3::EventAttendee.new(email: @enrollment.user.email))
    end
    respond_to do |format|
      format.html { redirect_to @enrollment.training_session, notice: 'Enrollment was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:attended, :user_id, :training_session_id)
    end
end
