# frozen_string_literal: true

class AuditsController < ApplicationController
  before_action :set_audit, only: [:show]

  def index

    @audit = Audit.new

    if audit_params.key?(:created_at) || audit_params.key?(:end_date)
      search_between_dates
    else
      search_params = audit_params
      search_params[:user_id] = nil if audit_params.key?(:user_id) &&
                                       audit_params[:user_id].eql?('nil')

      @audits = Audit.where(search_params).includes(:user).page params[:page]
    end
  end

  def show; end

  def users
    @users = if params[:q].blank?
               [{ id: 'nil', to_s: 'Not defined' }].concat User.order(:email).page(params[:page]).to_a
             else
               User.search(params[:q]).page(params[:page]).records.to_a
             end
  end

  def options
    options_result = Audit.pluck(params[:type]).uniq.select do |a|
      !params.key?(:q) || a.include?(params[:q])
    end
    @options = options_result.map { |a| { id: a, to_s: a } }
  end

  private

  def set_audit
    @audit = Audit.find(params[:id])
  end

  def audit_params
    params.fetch(:audit, {})
        .permit(:user_id, :auditable_type, :action, :created_at, :end_date, :q, :type)
        .reject {|_, v| v.blank?}
  end

  def search_between_dates
    if audit_params.key?(:created_at) && audit_params.key?(:end_date)
      @audits = Audit.where(created_at:
                                Date.parse(audit_params[:created_at])
                                    .beginning_of_day..
                                    Date.parse(audit_params[:end_date])
                                        .end_of_day).page params[:page]
    else
      flash.now[:alert] = 'You need to add both, a start date and end date'
    end
  end
end
