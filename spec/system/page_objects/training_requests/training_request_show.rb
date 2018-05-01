module PageObjects
  class TrainingRequestShow < BasePageObject

    # Set the value of the select2 combo for the requested by user id
    def select_requester(requester)
      page.execute_script("$('#requester_user_id').val(#{requester.id})")
    end

    def add_requester
      click_button("Add as Requester")
      TrainingRequestShow.new
    end

    def delete_requester requester_id
      page.accept_confirm { click_link("requester_#{requester_id}") }
      TrainingRequestShow.new
    end

    def vote
      click_button("Vote")
      VoteModal.new
    end

  end
end