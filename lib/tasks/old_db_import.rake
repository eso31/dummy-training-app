require 'awesome_print'
require 'benchmark'

def copy_timestamp_fields(attributes, old_row)
  mapping = {created_at: %w(created_date created_at), updated_at: %w(last_modified_date updated_at)}

  mapping.each {|new_field, old_field_aliases|

    old_field_aliases.each {|old_field|
      unless old_row[old_field].nil?
        attributes[new_field] = old_row[old_field]
      end
    }

  }
end


def copy_table(conn, old_sql_query, model, use= :import)
  old_rows_count = 0
  t = Benchmark.measure do
    rs = conn.exec(old_sql_query)
    puts "Copying #{rs.ntuples} #{old_sql_query} -----------------".yellow
    old_rows_count =rs.ntuples
    count = 0

    attr_array = Array.new
    rs.each do |old_row|
      count += 1
      attributes = yield old_row

      copy_timestamp_fields(attributes, old_row)

      instance = model.new(attributes)
      attr_array.push(instance)
      if use == :save

        print "#{count} of #{rs.ntuples}".white + " #{instance.to_s} saving...".gray
        if instance.save
          puts "\t saved".gray
        else
          instance.errors.messages.each {|msg|
            puts msg.to_s.redish
          }
        end
      end
    end
    if use == :import
      model.ar_import(attr_array, validate: false)
    end
  end
  if model.count != old_rows_count
    puts "Copied #{model.count} of #{old_rows_count} in the old table".red
  else
    puts "#{model.count} #{old_sql_query} records copied in #{f(t.total)} secs"
  end

  t
end

def copy_training_request_poll(conn)
  copy_table(conn, 'SELECT * from training_request_poll', TrainingRequestPoll) do |old_row|
    {
        'training_request_id': old_row['training_request_id'],
        'user_id': old_row['user_id'],
        'vote': old_row['vote'],
        'comment': old_row['comment']
    }
  end
end

def copy_training_request(conn)
  copy_table(conn, 'SELECT * from training_request', TrainingRequest) do |old_row|
    status = old_row['status'].downcase
    if status == 'new'
      status = 'pending_review'
    end
    {
        'id': old_row['id'],
        'name': old_row['name'],
        'description': old_row['description'],
        'location': old_row['location'],
        'duration_in_minutes': old_row['duration_in_minutes'], # TODO we need to refactor the rails code to rename `duration` to duration_in_minutes
        'start_date': old_row['start_date'],
        'end_date': old_row['end_date'],
        'status': status,
        'reference_file': old_row['reference_file'],
        'assigned_to_user_id': old_row['assigned_to_id'],
        'requested_by_user_id': old_row['requested_by_id']
    }
  end
end


def convert_to_new_role(old_role_name)
  old_role_name[/[^ROLE_].*/].downcase
end

def copy_users(conn)
  copy_table(conn, 'SELECT * from jhi_user', User) do |old_row|
    {
        id: old_row['id'],
        email: old_row['email'],
        first_name: old_row['first_name'],
        last_name: old_row['last_name'],
        password: 'secret'
    }
  end
end


def assign_roles(conn)
  new_db = ActiveRecord::Base.connection
  user_authority_count = 0
  t = Benchmark.measure do
    roles_cache = {}
    users_roles_sql_values = []
    rs_user_authority = conn.exec('select user_id, authority_name from jhi_user_authority')
    user_authority_count = rs_user_authority.ntuples
    puts "Copying #{rs_user_authority.ntuples} user roles -----------------".yellow

    rs_user_authority.each do |row|
      role_name = convert_to_new_role(row['authority_name'])

      unless roles_cache.key?(role_name)
        role = Role.find_by_name(role_name)
        roles_cache[role_name] = role.id
      end
      users_roles_sql_values << "(#{row['user_id']}, #{roles_cache[role_name]} )"
    end
    insert_sql = "insert into users_roles (user_id, role_id)
                  values #{users_roles_sql_values.join(',')}"

    new_db.exec_query(insert_sql)
  end
  users_roles_count = new_db.select_value('select count(*) from users_roles')

  if users_roles_count != user_authority_count
    puts "Copied #{users_roles_count} of #{user_authority_count} in the old table".red
  else
    puts "#{users_roles_count} jhi_user_authority records copied in #{f(t.total)} secs"
  end
  t
end

def copy_authority(conn)
  copy_table(conn, 'SELECT * from jhi_authority', Role) do |old_row|
    {
        name: convert_to_new_role(old_row['name'])
    }
  end
end

def copy_class_locations(conn)
  copy_table(conn, 'SELECT * from class_location', ClassLocation) do |old_row|
    {
        id: old_row['id'],
        name: old_row['name'],
        email: old_row['email'],
        timezone: old_row['timezone']
    }
  end
end


def copy_series(conn)
  copy_table(conn, 'SELECT * from course_series', Series) do |old_row|
    {
        id: old_row['id'],
        name: old_row['name'],
        description: old_row['description']
    }
  end
end


def copy_courses(conn)
  copy_table(conn, 'SELECT * from course', Course) do |old_row|
    {
        id: old_row['id'],
        title: old_row['title'],
        description: old_row['description'],
        duration_in_minutes: old_row['duration_in_minutes'],
        min_group_size: old_row['min_group_size'],
        max_group_size: old_row['max_group_size'],
        taught_by_user_id: old_row['teacher_id'],
        series_id: old_row['series_id']

    }
  end
end


def copy_training_session(conn)
  copy_table(conn, 'SELECT * from training_session', TrainingSession) do |old_row|
    instructor_attributes = []
    rs = conn.exec_params('SELECT * from instructor where training_session_id = $1', [old_row['id']])
    rs.each do |row|
      u = User.find(row['user_id'])
      instructor_attributes.push(u.attributes)
    end
    attributes ={
        id: old_row['id'],
        title: old_row['title'],
        description: old_row['description'],
        min_group_size: old_row['min_group_size'],
        max_group_size: old_row['max_group_size'].nil? ? old_row['min_group_size'] : old_row['max_group_size'],
        start_date: old_row['start_date'],
        class_location_id: old_row['class_location_id'],
        url: old_row['url'],
        duration_in_minutes: old_row['duration_in_minutes'],
        compensation: old_row['compensation'],
        compensation_delivered: old_row['compensation_delivered'],
        session_type: old_row['session_type'],
        course_id: old_row['course_id'],
        google_calendar_id: old_row['google_calendar_id'],
        google_calendar_event_id: old_row['google_calendar_event_id'],
        instructors_attributes: instructor_attributes
    }
    if attributes['description'].nil? || attributes['description'].empty?
      attributes['description'] = 'NEEDS DESCRIPTION'
    end

    attributes
  end
end


def copy_requesters(conn)
  copy_table(conn, 'SELECT * from training_requester', Requester) do |old_row|
    status = old_row['status'].downcase
    if status == 'new'
      status = 'pending_review'
    end
    {
        'id': old_row['id'],
        'user_id': old_row['user_id'],
        'training_request_id': old_row['training_request_id'],
        'status': status
    }
  end
end

def copy_enrollments(conn)
  copy_table(conn, 'SELECT * from enrollment', Enrollment) do |old_row|
    {
        id: old_row['id'],
        attended: old_row['attended'],
        user_id: old_row['user_id'],
        training_session_id: old_row['training_session_id']

    }
  end
end

def copy_assignment_queues(conn)
  copy_table(conn, 'SELECT * from assignment_queue', AssignmentQueue) do |old_row|
    {
        id: old_row['id'],
        assignment_order: old_row['assignment_order'],
        status: old_row['status'],
        user_id: old_row['lead_user_id'],
        training_request_id: old_row['training_request_id']
    }
  end
end

def copy_ledger_categories(conn)
  copy_table(conn, 'SELECT * from ledger_category', LedgerCategory) do |old_row|
    {
        id: old_row['id'],
        name: old_row['name']
    }
  end
end

def copy_rating_reasons(conn)
  copy_table(conn, 'SELECT * from rating_reason', RatingReason) do |old_row|
    {
        id: old_row['id'],
        description: old_row['description'],
        rating_type: old_row['session_rating_type']
    }
  end
end

def copy_session_ratings(conn)
  copy_table(conn, 'SELECT * from session_rating', SessionRating) do |old_row|
    session_rating_reason_attributes = []
    rs = conn.exec_params('SELECT * from session_rating_reason where session_rating_id = $1', [old_row['id']])
    rs.each do |row|
      r = RatingReason.find(row['rating_reason_id'])
      session_rating_reason_attributes.push(r.attributes)
    end
    attributes =
    {
        id: old_row['id'],
        rating: old_row['rating'],
        user_type: old_row['type'],
        comment: old_row['comment'],
        enrollment_id: old_row['enrollment_id'],
        user_id: old_row['user_id']
    }
  end
end

def copy_financial_accounts(conn)
  copy_table(conn, 'SELECT * from financial_account', FinancialAccount) do |old_row|
    {
        id: old_row['id'],
        status: old_row['status'],
        name: old_row['name'],
        parent_account_id: old_row['parent_account_id']
    }
  end
end

def copy_general_ledger(conn)
  copy_table(conn, 'SELECT * from general_ledger', GeneralLedger) do |old_row|
    {
        id: old_row['id'],
        transaction_type: old_row['transaction_type'],
        description: old_row['description'],
        transaction_date: old_row['transaction_date'],
        amount: old_row['amount'],
        financial_account_id: old_row['account_id'],
        ledger_category_id: old_row['category_id'],
        training_request_id: old_row['training_request_id'],
        training_session_id: old_row['training_session_id']
    }
  end
end


def clean_new_database
  t = Benchmark.measure do
    GeneralLedger.delete_all
    SessionRating.delete_all
    RatingReason.delete_all
    TrainingSession.delete_all
    Course.delete_all
    Series.delete_all
    Requester.delete_all
    TrainingRequestPoll.delete_all
    TrainingRequest.delete_all
    User.delete_all
    Role.delete_all
    ClassLocation.delete_all
    Enrollment.delete_all
    AssignmentQueue.delete_all
    FinancialAccount.delete_all
    LedgerCategory.delete_all
  end
  puts "database cleaned in #{f(t.total)} secs"

  t
end

def update_sequences
  t = Benchmark.measure do

    puts 'updating sequences   -----------------'.yellow

    %w[
      class_locations_id_seq
      users_id_seq
      training_requests_id_seq
      requesters_id_seq
      series_id_seq
      rating_reasons_id_seq
      courses_id_seq
      assignment_queues_id_seq
      training_request_polls_id_seq
      financial_accounts_id_seq
      ledger_categories_id_seq
      training_sessions_id_seq
      general_ledgers_id_seq
      enrollments_id_seq
      audits_id_seq
      roles_id_seq
      session_ratings_id_seq
  ].each do |sequence_name|
      table_name = sequence_name.sub '_id_seq', ''
      query = "SELECT setval('#{sequence_name}',
                      (SELECT GREATEST(MAX(id)+1,nextval('#{sequence_name}')) FROM #{table_name}))"
      ActiveRecord::Base.connection.exec_query(query);
    end

  end
  puts "updated sequences  in #{f(t.total)} secs"
  t

end

def f(total_time)
  '%.02f' % total_time
end

namespace :old_db_import do
  desc 'Task to copy all the data from the old database to the rails db'

  task execute: :environment do
    old_db = PG.connect(host: 'postgres', dbname: 'training_prod_old', user: 'postgres')


    total_time = clean_new_database
    total_time += copy_class_locations(old_db)
    total_time += copy_authority(old_db)
    total_time += copy_users(old_db)
    total_time += assign_roles(old_db)
    total_time += copy_training_request(old_db)
    total_time += copy_requesters(old_db)
    total_time += copy_training_request_poll(old_db)
    total_time += copy_series(old_db)
    total_time += copy_courses(old_db)
    total_time += copy_training_session(old_db)
    total_time += copy_enrollments(old_db)
    total_time += copy_assignment_queues(old_db)
    total_time += copy_ledger_categories(old_db)
    total_time += copy_financial_accounts(old_db)
    total_time += copy_general_ledger(old_db)
    total_time += copy_rating_reasons(old_db)
    total_time += copy_session_ratings(old_db)
    total_time += update_sequences


    puts "Old database copied in #{f(total_time.total)} secs".blue

  end

end
