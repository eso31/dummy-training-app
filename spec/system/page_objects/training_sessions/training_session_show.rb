module PageObjects
  class TrainingSessionShow < BasePageObject

    def click_enroll
      click_link 'Enroll'
      TrainingSessionShow.new
    end

    def check_attended(user_id)
      check("attended-#{user_id}")
      TrainingSessionShow.new
    end

   def rate rate
     click_link("rate_#{rate}")
     ModalRate.new
   end
  end
end
