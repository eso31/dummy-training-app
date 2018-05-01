class GeneralLedgersController < ApplicationController

  load_and_authorize_resource

  before_action :set_general_ledger, only: %i[show edit update destroy link]
  include ActionView::Helpers::TextHelper

  # GET /general_ledgers
  # GET /general_ledgers.json
  def index
    @general_ledgers = if params[:q].blank?
                         GeneralLedger
                           .order(created_at: :desc)
                           .includes(:ledger_category, :financial_account,
                                     :training_request, :training_session).page params[:page]
                       else
                         GeneralLedger.search(params[:q]).page(params[:page]).records
                       end
  end

  # GET /general_ledgers/1
  # GET /general_ledgers/1.json
  def show; end

  # GET /general_ledgers/new
  def new
    @general_ledger = GeneralLedger.new
  end

  # GET /general_ledgers/1/edit
  def edit; end

  # POST /general_ledgers
  # POST /general_ledgers.json
  def create
    @general_ledger = GeneralLedger.new(general_ledger_params)

    respond_to do |format|
      if @general_ledger.save
        respond_to_create format
      else
        redirect_to_view format
      end
    end
  end

  # PATCH/PUT /general_ledgers/1
  # PATCH/PUT /general_ledgers/1.json
  def update
    respond_to do |format|
      if @general_ledger.update(general_ledger_params)
        format.html { redirect_to @general_ledger, notice: 'General ledger was successfully updated.' }
        format.json { render :show, status: :ok, location: @general_ledger }
      else
        format.html { render :edit }
        format.json { render json: @general_ledger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /general_ledgers/1/link
  def link
    raise ActionController::RoutingError, 'Not Found' unless
        general_ledger_params.key?(:training_session_id) ||
        general_ledger_params.key?(:training_request_id)

    @general_ledger.update(general_ledger_params)

    redirect_to_training_object
  end

  # DELETE /general_ledgers/1
  # DELETE /general_ledgers/1.json
  def destroy
    @general_ledger.destroy
    respond_to do |format|
      format.html { redirect_to general_ledgers_url, notice: 'General ledger was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET training_session/:training_session_id/general_ledgers/link
  # GET training_request/:training_request_id/general_ledgers/link
  def show_link
    if params.key? :training_session_id
      configure_training_session
    elsif params.key? :training_request_id
      configure_training_request
    else
      raise ActionController::RoutingError, 'Not Found'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_general_ledger
    @general_ledger = GeneralLedger.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def general_ledger_params
    params.require(:general_ledger)
          .permit(:transaction_type,
                  :description,
                  :transaction_date, :amount,
                  :financial_account_id,
                  :training_request_id,
                  :training_session_id,
                  :ledger_category_id)
  end


  #redirects to a different view depending where the general_ledger was tried to be created and failed
  def redirect_to_view format
    if params.has_key?(:general_ledger_modal)
      format.html do
        #TODO Find a way to show the errors on a redirect_to
        if @general_ledger.training_request
          redirect_to training_request_path(@general_ledger.training_request, load_ledger: true), notice: "You need to fill the General ledger with valid fields"
        else
          redirect_to training_session_path(@general_ledger.training_session, load_ledger: true), notice: "You need to fill the General ledger with valid fields"
        end
      end
    else
      format.html {render :new}
    end
    format.json { render json: @general_ledger.errors, status: :unprocessable_entity }
  end

  def respond_to_create(format)
    format.html do
      if params.key? 'redirect'
        redirect_to training_request_path(@general_ledger.training_request), notice: 'General ledger entry was successfully created.'
      else
        redirect_to @general_ledger, notice: 'General ledger was successfully created.'
      end
    end
    format.json { render :show, status: :created, location: @general_ledger }
  end

  # Filter the searched ledgers from those who don't have a training request
  # or those who don't have a training session
  def available_ledgers(type)
    @general_ledgers = search_ledgers.where(type => nil).page params[:page]
  end

  # Search for the ledgers with the search params from the request
  def search_ledgers
    if params[:q].blank?
      GeneralLedger
        .order(created_at: :desc)
        .includes(:ledger_category, :financial_account,
                  :training_request, :training_session)
    else
      GeneralLedger.search(params[:q])
    end
  end

  # Look for the training request on the params
  def set_training_request
    @training_request = TrainingRequest.find(params[:training_request_id])
  end

  # Look for the training session on the params
  def set_training_session
    @training_session = TrainingSession.find(params[:training_session_id])
  end

  # Set the variables for a training session link on general ledgers
  def configure_training_session
    available_ledgers :training_session
    set_training_session
  end

  # Set the variables for a training request link on general ledgers
  def configure_training_request
    available_ledgers :training_request
    set_training_request
  end

  # Redirect to the training request or to the training session
  # depending on the training object established on the parameters
  def redirect_to_training_object
    if general_ledger_params.key? :training_session_id
      redirect_to training_session_path(
        general_ledger_params[:training_session_id]
      ), notice: 'General ledger was successfully linked.'
    elsif general_ledger_params.key? :training_request_id
      redirect_to training_request_path(
        general_ledger_params[:training_request_id]
      ), notice: 'General ledger was successfully linked.'
    end
  end

end
