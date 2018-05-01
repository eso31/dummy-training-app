module PageObjects
  class CoursesForm < BasePageObject

    def select_taught_by_user(user)
      page.execute_script("$('#course_taught_by_user_id').val(#{user.id})")
    end

    def select_series(series)
      page.execute_script("$('#course_series_id').val(#{series.id})")
    end

    def click_create
      click_button 'Create Course'
      CourseShow.new
    end

  end
end