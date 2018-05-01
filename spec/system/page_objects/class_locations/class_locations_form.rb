module PageObjects
  class ClassLocationsForm < BasePageObject

    def click_create
      click_button 'Create Class location'
      ClassLocationShow.new
    end
  end
end

