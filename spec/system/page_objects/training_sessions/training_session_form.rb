# frozen_string_literal: true

module PageObjects

  # Class who represents the Page Object of the training session form
  class TrainingSessionForm < BasePageObject

    def select_class_location(class_location)
      page.execute_script"$('#training_session_class_location_id').val(#{class_location.id})"
    end

    def select_course(course)
      page.execute_script"$('#training_session_course_id').val(#{course.id})"
    end

    def select_instructors(instructors)
      # Set instructors as array if is not an array yet
      instructors = [instructors] unless instructors.respond_to? 'each'

      # Set the value of the instructors
      page.execute_script "$('#training_session_instructor_ids_').val(#{instructors.map(&:id)})"
    end

    def click_create
      click_button 'Create Training session'
      TrainingRequestShow.new
    end

    def click_update
      click_button 'Update Training session'
      TrainingRequestShow.new
    end
  end

end
