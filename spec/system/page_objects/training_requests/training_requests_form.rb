module PageObjects
  class TrainingRequestsForm < BasePageObject

    # Set the value of the select2 combo for the assigned to user id
    def select_assigned_user(user)
      page.execute_script("$('#training_request_assigned_to_user_id').val(#{user.id})")
    end

    # Set the value of the select2 combo for the requested by user id
    def select_request_by_user(user)
      page.execute_script("$('#training_request_requested_by_user_id').val(#{user.id})")
    end

    def click_create
      click_button 'Create Training request'
      TrainingRequestShow.new
    end
  end
end