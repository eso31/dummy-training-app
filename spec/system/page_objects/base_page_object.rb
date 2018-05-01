# frozen_string_literal: true

module PageObjects
  class BasePageObject
    include Capybara::DSL

    def alerts
      find('.alert')
    end

    def fill_fields(options)
      options.each do |key, value|
        fill_in key, with: value
      end
    end

    def login(email, password)
      fill_in 'Email', with: email
      fill_in 'Password', with: password

      click_button 'Log in'
    end

    def search(search_text)
      begin
        fill_in 'q', with: search_text
      rescue Capybara::ElementNotFound
        STDERR.puts "The view don't have a search box"
        raise Capybara::ElementNotFound
      end

      click_button 'Search'
    end
  end
end
