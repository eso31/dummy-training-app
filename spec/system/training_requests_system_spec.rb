# frozen_string_literal: true

require 'rails_helper'
require_relative 'page_objects/workflows'

RSpec.describe 'Training Requests', type: :system do
  include PageObjects

  let(:requested_by) { create(:user) }
  let(:assigned_to) { create(:training_admin) }

  it 'enables me to create a training request as a normal user' do
    login_as(create(:user), scope: :user)
    form_page = as_user_visit_training_request_new

    form_page.fill_fields(
      'Name': 'Home',
      'Description': 'Description',
      'Location': 'Mexico City',
      'Duration in minutes': 30,
      'training_request[start_date]': '2017-11-21'
    )

    # Set the values of the select2 combos via JS
    form_page.select_assigned_user assigned_to

    show_page = form_page.click_create
    expect(show_page.alerts).to have_content(/Training Request was successfully created/i)
  end

  it 'enables me to create a training request as an admin user' do
    login_as(create(:admin), scope: :user)
    form_page = as_user_visit_training_request_new

    form_page.fill_fields(
      'Name': 'Home',
      'Description': 'Description',
      'Location': 'Mexico City',
      'Duration in minutes': 30,
      'training_request[start_date]': '2017-11-21'
    )

    form_page.select('approved', from: 'training_request[status]')

    # Set the values of the select2 combos via JS
    # form_page.select_assigned_user assigned_to
    form_page.select_request_by_user requested_by

    show_page = form_page.click_create
    expect(show_page.alerts).to have_content(/Training Request was successfully created/i)
  end

  describe 'as training admin' do

    it 'enables me to delete a training requester' do
      training_request = create(:training_request)
      requester = create(:requester, training_request: training_request)
      second_requester = create(:requester, training_request: training_request)

      login_as(create(:admin), scope: :user)
      show_page = as_an_admin_visit_training_request_show(training_request)

      show_page.click_link('Requesters')

      show_page = show_page.delete_requester(requester.id)

      expect(show_page).to_not have_content(requester.user.full_name)
      expect(show_page).to have_content(second_requester.user.full_name)
    end

    it 'Should search a Training Request and add a Requester' do
      admin = create(:admin)
      requester = create(:user)
      training_request = create(:training_request)
      # Create the requester of the training request
      Requester.create(user: requester, training_request: training_request)

      sleep 1

      # Visit the training requests index page
      form_page = as_training_admin_visit_home
      form_page.login(admin.email, admin.password)

      form_page.save_screenshot

      # Search for the training request and visit it
      form_page = form_page.search(training_request.name)
      show_page = form_page.select_training_request(training_request)

      # Get the length of the training request
      requester_length = within(show_page.find('#requesters')) do
        find_all(:css, '.requester')
      end.length

      # Add the new requester
      show_page.select_requester requester
      show_page = show_page.add_requester

      # Get the new length of the requester list
      new_requester_length = within(show_page.find('#requesters')) do
        find_all(:css, '.requester')
      end.length

      # Make the assertions
      expect(new_requester_length).to eql(requester_length + 1)
      expect(show_page).to have_content(requester.full_name)
    end

    it 'look for training requests using advanced search and status' do
      t_admin = create(:training_admin)
      training_request = create(:training_request, status: 'APPROVED')
      second_training_request = create(:training_request, status: 'NOT_APPROVED')

      sleep 1

      tr_page = visit_training_requests_index
      tr_page.login(t_admin.email, t_admin.password)

      tr_page.click_link_or_button 'advanced'

      tr_page.select('Not Approved', from: 'Status')

      tr_page.find(:css, 'button[name=search_widget]').click

      expect(tr_page).to have_content(second_training_request.name)
      expect(tr_page).not_to have_content(training_request.name)
    end

    it 'look for training requests using advanced search and created at' do
      t_admin = create(:training_admin)
      training_request = create(:training_request)
      second_training_request = create(:training_request,
                                       created_at: Date.today.prev_month)

      sleep 1

      tr_page = visit_training_requests_index
      tr_page.login(t_admin.email, t_admin.password)

      tr_page.click_link_or_button 'advanced'

      tr_page.fill_fields(
        'Start Date': Date.today.prev_month.yesterday,
        'End Date': Date.today.prev_month.tomorrow
      )

      tr_page.find(:css, 'button[name=search_widget]', wait: 2).click

      expect(tr_page).to have_content(second_training_request.name)
      expect(tr_page).not_to have_content(training_request.name)
    end

    it 'enables me to vote for a training request as an admin' do
      training_request = create(:training_request)

      login_as(create(:admin), scope: :user)
      show_page = as_an_admin_visit_training_request_show(training_request)

      show_page.click_link('Votes')

      vote_modal = show_page.vote

      vote_modal.fill_fields(
        'Comment': 'admin comment'
      )

      vote_modal.select('not_approved', from: 'training_request_poll[vote]')

      show_page = vote_modal.save

      show_page.click_link('Votes')

      expect(show_page).to have_content('admin comment')
    end
  end
end
