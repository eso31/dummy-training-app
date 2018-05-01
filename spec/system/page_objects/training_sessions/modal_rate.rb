module PageObjects
  class ModalRate < BasePageObject

    def create
      click_button('Create Session rating')
      TrainingSessionShow.new
    end

  end
end
