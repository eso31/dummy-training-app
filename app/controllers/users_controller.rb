# frozen_string_literal: true

class UsersController < ApplicationController

  include AdvancedSearchHelper

  load_and_authorize_resource except: %i[available_training_admins]

  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_current_user, only: %i[edit_settings edit_password]

  # GET /users
  # GET /users.json
  def index
    @users = if params[:q].blank?
               User.order(:email).page params[:page]
             else
               elastic_search_results(User)
             end
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  def edit_settings; end

  def edit_password; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.add_role(:user)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(update_user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_settings
    respond_to do |format|
      if current_user.update(update_user_params)
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: current_user }
      else
        update_user_params.has_key?(:password) ? format.html { render :edit_password } : format.html { render :edit_settings }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /users/available_admins.json
  def available_training_admins
    respond_to do |format|
      # format.html { raise ActionController::RoutingError, 'Not Found' }
      format.json do
        set_training_admins
        render :index, status: :ok
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end

  def set_training_admins
    @users = AssignmentQueue.queue.map(&:user)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.fetch(:user, {})
          .permit(:q, :email, :password, :password_confirmation, :first_name,
                  :last_name, :vegetarian, :notification, role_ids: [])
  end

  def q_params
    params.require(:q)
          .permit(:email, :first_name, :last_name,
                  created_at: %i[start_date end_date])
  end

  # Remove the password to not validate it if is blank
  def update_user_params
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    add_not_related_roles
  end

  # Add the instructor and user roles that the user already have
  def add_not_related_roles
    current_params = user_params.clone

    if user_params.key? :role_ids
      current_params[:role_ids] += @user
                                   .roles
                                   .where(name: %w[instructor user])
                                   .map { |u| u.id.to_s }
    end

    current_params
  end

end