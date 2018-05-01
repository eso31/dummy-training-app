# frozen_string_literal: true

require 'rails_helper'
require_relative 'page_objects/workflows'

RSpec.describe 'Users', type: :system do
  include PageObjects

  describe 'As an admin' do
    it 'enables me to create a user and add roles' do
      admin = create(:admin)

      Role.create(name: :training_admin)
      Role.create(name: :workshops_admin)
      Role.create(name: :financial_admin)

      form_page = as_admin_visit_new_user

      # Login as a training admin
      form_page.login(admin.email, admin.password)

      form_page.fill_fields(
        'First name': 'Ivan',
        'Last name': 'Garcia',
        'Email': 'test@example.com',
        'Password': '123456',
        'Password confirmation': '123456'
      )

      form_page.check 'Vegetarian'

      form_page.check('Admin')
      form_page.check('Training admin')
      form_page.check('Financial admin')
      form_page.check('Workshops admin')

      show_page = form_page.click_create
      expect(show_page.alerts).to have_content(/User was successfully created/i)

      user = User.find_by_email('test@example.com')

      expect(user.has_role?(:user)).to be_truthy
      expect(user.has_role?(:admin)).to be_truthy
      expect(user.has_role?(:training_admin)).to be_truthy
      expect(user.has_role?(:workshops_admin)).to be_truthy
      expect(user.has_role?(:financial_admin)).to be_truthy

    end

    it 'enables me to add all roles to users' do
      Role.create(name: :training_admin)
      Role.create(name: :workshops_admin)
      Role.create(name: :financial_admin)

      # Create the user and visit that page
      user = create(:user)
      form_page = visit_edit_user_page(user)

      # Then login as an admin
      admin = create(:admin)
      form_page.login(admin.email, admin.password)

      # Set the roles
      form_page.check('Admin')
      form_page.check('Training admin')
      form_page.check('Financial admin')
      form_page.check('Workshops admin')

      form_page.click_update

      expect(user.has_role?(:user)).to be_truthy
      expect(user.has_role?(:admin)).to be_truthy
      expect(user.has_role?(:training_admin)).to be_truthy
      expect(user.has_role?(:workshops_admin)).to be_truthy
      expect(user.has_role?(:financial_admin)).to be_truthy
    end

    it 'should look for users using advanced search and first name' do
      admin = create(:admin)
      user = create(:user, first_name: 'first_user', last_name: 'first_user')
      second_user = create(:user, first_name: 'second_user', last_name: 'second_user')

      # Wait for elasticsearch to index the records
      sleep 1

      users_page = as_admin_visit_users
      users_page.login(admin.email, admin.password)

      users_page.click_link_or_button 'advanced'

      users_page.fill_fields(
        'First name': user.first_name
      )

      users_page.find(:css, 'button[name=search_widget]').click

      expect(users_page).to have_content(user.full_name)
      expect(users_page).not_to have_content(second_user.full_name)
    end

    it 'looks for users using advanced search last name' do
      admin = create(:admin)
      user = create(:user, first_name: 'first_user', last_name: 'first_user')
      second_user = create(:user, first_name: 'second_user', last_name: 'second_user')

      # Wait for elasticsearch to index the records
      sleep 1

      users_page = as_admin_visit_users
      users_page.login(admin.email, admin.password)

      users_page.click_link_or_button 'advanced'

      users_page.fill_fields(
        'Last name': user.last_name
      )

      users_page.find(:css, 'button[name=search_widget]').click

      expect(users_page).to have_content(user.full_name)
      expect(users_page).not_to have_content(second_user.full_name)
    end

    it 'look for users using advanced search and email' do
      admin = create(:admin)
      user = create(:user)
      second_user = create(:user)

      # Wait for elasticsearch to index the records
      sleep 1

      users_page = as_admin_visit_users
      users_page.login(admin.email, admin.password)

      users_page.click_link_or_button 'advanced'

      users_page.fill_fields(
        'Email': second_user.email
      )

      users_page.find(:css, 'button[name=search_widget]').click

      expect(users_page).to have_content(second_user.full_name)
      expect(users_page).not_to have_content(user.full_name)
    end
  end

  describe 'As user' do
    it 'should be able to update all settings' do
      form_page = visit_settings_view

      # Login as normal user
      user = build(:user)
      user.vegetarian = false
      user.notification = false
      user.save!

      form_page.login(user.email, user.password)

      # Create new user data
      new_data = build(:user)

      # Test values before the check
      expect(form_page)
        .to have_content(/User settings for: #{user.full_name}/)

      expect(form_page)
        .to have_content(/#{user.first_name}/)

      expect(form_page)
        .to have_content(/#{user.last_name}/)

      expect(form_page.find_field('Vegetarian')).to_not be_checked
      expect(form_page.find_field('Notification')).to_not be_checked

      form_page.fill_fields(
        'First name': new_data.first_name,
        'Last name': new_data.last_name
      )

      form_page.find_field('Vegetarian').set(true)
      form_page.find_field('Notification').set(true)

      updated_page = form_page.update_settings

      # Test values after the check
      expect(updated_page).to have_content('User was successfully updated.')
    end

    it 'should enables me to change my password' do
      form_page = visit_password_view

      # Login as normal user
      user = create(:user)

      form_page.login(user.email, user.password)

      new_pass = Faker::Internet.password(8, 16)

      form_page.fill_fields(
        'New password': new_pass,
        'New password confirmation': new_pass
      )

      show_page = form_page.click_change

      form_page.login(user.email, new_pass)

      expect(show_page.alerts).to have_content(/Signed in successfully/i)
    end
  end
end
