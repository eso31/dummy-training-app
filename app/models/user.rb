# frozen_string_literal: true
require 'elasticsearch/model'

class User < ApplicationRecord
  rolify

  include Searchable
  audited
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :training_sessions, through: 'instructors'
  has_many :enrollments
  has_many :assignment_queues
  validates :first_name, :last_name, presence: true

  # Get the user from the oauth hash values
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    if user.nil?
      user = User.create(email: data['email'],
                         password: Devise.friendly_token[0, 20],
                         first_name: data['first_name'],
                         last_name: data['last_name'],
                         image: data['image'])
    else
      #refresh data
      user.update(first_name: data['first_name'],
                  last_name: data['last_name'],
                  image: data['image'])
    end

    user
  end

  def full_name
    first_name && last_name ? first_name + ' ' + last_name : ''
  end

  def to_s
    "#{first_name} #{last_name}<#{email}>"
  end

  # Callbacks
  before_create do |u|
    u.add_role :user
  end
end
