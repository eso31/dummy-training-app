require 'elasticsearch/model'


class TrainingSession < ApplicationRecord
  resourcify
  audited
  include Searchable

  enum session_type: {
    workshop: 'WORKSHOP',
    in_person_class: 'IN_PERSON_CLASS',
    online_class: 'ONLINE_CLASS'
  }

  belongs_to :course, optional: true
  belongs_to :class_location
  has_many :enrollments
  has_many :general_ledgers

  has_and_belongs_to_many :instructors, class_name: 'User', join_table: 'instructors'
  accepts_nested_attributes_for :instructors

  validates :title, presence: true
  validates :description, presence: true
  validates :min_group_size, presence: true
  validates :max_group_size, presence: true
  validates :start_date, presence: true
  validates :duration_in_minutes, presence: true, numericality: true
  validates :session_type, presence: true, inclusion: {in: session_types.keys, message: 'The value: %{value} is not a valid session type'}


  def instructors_attributes=(attributes)
    self.instructors = attributes.map { |user| User.find(user['id']) }
    super(attributes)
  end

  def full?
    enrollments.count >= max_group_size
  end

  def enrolled_user?(user)
    enrollments.any? { |e| e.user_id == user.id }
  end

  def enrolled_and_attended_user?(user)
    enrollments.any? { |e| e.user_id == user.id && e.attended }
  end

  def attendance
    enrollments.where(attended: true).count
  end

  # Callbacks
  after_save do

    # Clean the preview instructors list
    current_instructors = User.with_role(:instructor, self).preload(:roles)
    current_instructors.each do |i|
      i.remove_role(:instructor, self) if i.has_cached_role?(:instructor, self)
    end

    # Set the users in the instructors list as instructors of
    # the training session
    instructors.each { |u| u.add_role(:instructor, self) }
  end

  def total_planned
    total_type 'PLANNED'
  end

  def total_debit
    total_type 'DEBIT'
  end

  def total_credit
    total_type('CREDIT') * -1
  end

  def end_date
    start_date + duration_in_minutes.minutes
  end

  def summary
    "#{title}: #{description}"
  end

  def enrolled_and_instructors_ids
    enrollments.map(&:id).concat(instructors.ids)
  end

  def start_time
    begin
      "#{start_date.hour}:#{'%02d' % start_date.min}"
    rescue NoMethodError
      ""
    end
  end

  private

  def total_type type
    Money.new(general_ledgers.select { |gl| gl.transaction_type == type }
      .inject(0) { |sum, gl| sum + gl.amount } * 100)
  end
end
