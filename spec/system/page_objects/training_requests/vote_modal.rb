module PageObjects
  class VoteModal < BasePageObject

    def save
      click_button("Save")
      TrainingRequestShow.new
    end

  end
end