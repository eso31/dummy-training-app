# frozen_string_literal: true

require 'database_cleaner'
require 'webmock/rspec'
require 'rspec-html-matchers'
require 'capybara/poltergeist'
require 'phantomjs'
require 'google/apis/calendar_v3'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  calendar =
    {
      "kind": 'calendar#event',
      "etag": '\\"3031586836768000\\"',
      "id": 'npfc00hde0b0kmngp4t3uavuho',
      "status": 'confirmed',
      "htmlLink": 'https://www.google.com/calendar/event?eid=bnBmYzAwaGRlMGIwa21uZ3A0dDN1YXZ1aG8gbmVhcnNvZnQuY29tX284dXAwbjAya2MzZjY2dGFxZmlkOTN0cGtjQGc',
      "created": '2018-01-12T21:43:38.000Z',
      "updated": '2018-01-12T21:43:38.384Z',
      "summary": 'Stub for the google calendar: Hello world',
      "creator": {
        "email": 'calendar@training-app-184016.iam.gserviceaccount.com'
      },
      "attendees": [],
      "organizer": {
        "email": 'nearsoft.com_o8up0n02kc3f66taqfid93tpkc@group.calendar.google.com',
        "displayName": 'Testing training-app',
        "self": true
      },
      "start": {
        "dateTime": '2018-01-12T15:41:00-06:00'
      },
      "end": {
        "dateTime": '2018-01-12T17:41:00-06:00'
      },
      "iCalUID": 'npfc00hde0b0kmngp4t3uavuho@google.com',
      "sequence": 0,
      "reminders": {
        "useDefault": true
      }
    }

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random
  config.include RSpecHtmlMatchers

  config.before(:suite) do
    WebMock.stub_request(:any, 'http://localhost')
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    # Now we need to set an elasticsearch running server
    # to test the elasticsearch associated actions
    #
    # WebMock.stub_request(:any, /localhost:9200/)
    #        .to_return(status: 200, body: '{hits: {total: 0}}', headers: {})
    #

    # Stubs for the google calendar API requests
    WebMock.stub_request(:post, 'https://www.googleapis.com/oauth2/v4/token')
           .to_return(status: [200, ''],
                      headers: { 'Content-Type' => 'application/json' },
                      body: '{"access_token": "foo"}')

    WebMock.stub_request(:get, %r{https://www\.googleapis\.com/calendar/v3/calendars/*/events/})
           .to_return(
             status: 200, body: calendar.to_json,
             headers: {
               'Content-Type' => 'application/json'
             }
           )

    WebMock.stub_request(:put, 'https://www.googleapis.com/calendar/v3/calendars//events/?sendNotifications=true')
           .to_return(status: 200,
                      body: '{}')

    WebMock.stub_request(:post, 'https://www.googleapis.com/calendar/v3/calendars//events?sendNotifications=true')
           .to_return(status: 200, body: '{}', headers: { 'Content-Type' => 'application/json' })

    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:each, type: :system) do
    # driven_by :selenium, using: :chrome
    driven_by :poltergeist, options: { phantomjs: Phantomjs.path, js_errors: true }
  end
end
