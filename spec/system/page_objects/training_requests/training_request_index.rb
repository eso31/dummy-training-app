module PageObjects
  class TrainingRequestIndex < BasePageObject

    # Click view button of the parameter's training request
    def select_training_request(training_request)

      # Get the button for the training request
      current_element = find(
        'tr',
        id: "training_request_#{training_request.id}"
      )

      # Click the show button of the element found
      within current_element do
        find('a', text: training_request.name).click
      end

      TrainingRequestShow.new
    end

    def search(tr_name)
      super(tr_name)
      TrainingRequestIndex.new
    end
  end
end
