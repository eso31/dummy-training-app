class RatingReasonsController < ApplicationController
  before_action :set_rating_reason, only: [:show, :edit, :update, :destroy]

  # GET /rating_reasons
  # GET /rating_reasons.json
  def index
    @rating_reasons = RatingReason.order(:description).page params[:page]
  end

  # GET /rating_reasons/1
  # GET /rating_reasons/1.json
  def show; end

  # GET /rating_reasons/new
  def new
    @rating_reason = RatingReason.new
  end

  # GET /rating_reasons/1/edit
  def edit; end

  # POST /rating_reasons
  # POST /rating_reasons.json
  def create
    @rating_reason = RatingReason.new(rating_reason_params)

    respond_to do |format|
      if @rating_reason.save
        format.html { redirect_to @rating_reason, notice: 'Rating reason was successfully created.' }
        format.json { render :show, status: :created, location: @rating_reason }
      else
        format.html { render :new }
        format.json { render json: @rating_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rating_reasons/1
  # PATCH/PUT /rating_reasons/1.json
  def update
    respond_to do |format|
      if @rating_reason.update(rating_reason_params)
        format.html { redirect_to @rating_reason, notice: 'Rating reason was successfully updated.' }
        format.json { render :show, status: :ok, location: @rating_reason }
      else
        format.html { render :edit }
        format.json { render json: @rating_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rating_reasons/1
  # DELETE /rating_reasons/1.json
  def destroy
    @rating_reason.destroy
    respond_to do |format|
      format.html { redirect_to rating_reasons_url, notice: 'Rating reason was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rating_reason
    @rating_reason = RatingReason.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rating_reason_params
    params.require(:rating_reason).permit(:description, :rating_type)
  end
end
