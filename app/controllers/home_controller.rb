class HomeController < ApplicationController

  include AdvancedSearchHelper

  def index
    if current_user.has_cached_role?(:training_admin) || current_user.has_cached_role?(:admin)
      if params[:q].blank?
        @training_requests = TrainingRequest
                             .where.not(status: 'approved')
                             .where.not(status: 'not_approved')
                             .order(start_date: :desc)
                             .includes(:assigned_to_user, :requested_by_user)
                             .page params[:page]
      else
        @training_requests = elastic_search_results(TrainingRequest)
      end
    else
      @training_sessions = TrainingSession.where("published = ? AND start_date >= ?", true, Date.today ).order(start_date: :desc).includes(:course, :class_location).page params[:page]
    end
  end

  # Accepted params for elasticsearch
  def q_params
    params.require(:q)
          .permit(:requested_by_user_id, :assigned_to_user_id, :status,
                  created_at: %i[start_date end_date])
  end
end