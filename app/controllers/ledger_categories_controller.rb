class LedgerCategoriesController < ApplicationController

  load_and_authorize_resource

  before_action :set_ledger_category, only: [:show, :edit, :update, :destroy]

  # GET /ledger_categories
  # GET /ledger_categories.json
  def index
    @ledger_categories = LedgerCategory.all.page(params[:page])
  end

  # GET /ledger_categories/1
  # GET /ledger_categories/1.json
  def show
  end

  # GET /ledger_categories/new
  def new
    @ledger_category = LedgerCategory.new
  end

  # GET /ledger_categories/1/edit
  def edit
  end

  # POST /ledger_categories
  # POST /ledger_categories.json
  def create
    @ledger_category = LedgerCategory.new(ledger_category_params)

    respond_to do |format|
      if @ledger_category.save
        format.html { redirect_to @ledger_category, notice: 'Ledger category was successfully created.' }
        format.json { render :show, status: :created, location: @ledger_category }
      else
        format.html { render :new }
        format.json { render json: @ledger_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ledger_categories/1
  # PATCH/PUT /ledger_categories/1.json
  def update
    respond_to do |format|
      if @ledger_category.update(ledger_category_params)
        format.html { redirect_to @ledger_category, notice: 'Ledger category was successfully updated.' }
        format.json { render :show, status: :ok, location: @ledger_category }
      else
        format.html { render :edit }
        format.json { render json: @ledger_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ledger_categories/1
  # DELETE /ledger_categories/1.json
  def destroy
    @ledger_category.destroy
    respond_to do |format|
      format.html { redirect_to ledger_categories_url, notice: 'Ledger category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ledger_category
      @ledger_category = LedgerCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ledger_category_params
      params.require(:ledger_category).permit(:name)
    end
end
