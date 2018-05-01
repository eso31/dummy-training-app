class ClassLocationsController < ApplicationController
  before_action :set_class_location, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  # GET /class_locations
  # GET /class_locations.json
  def index
    @class_locations = ClassLocation.order(:name).page params[:page]
  end

  # GET /class_locations/1
  # GET /class_locations/1.json
  def show
  end

  # GET /class_locations/new
  def new
    @class_location = ClassLocation.new
  end

  # GET /class_locations/1/edit
  def edit
  end

  # POST /class_locations
  # POST /class_locations.json
  def create
    @class_location = ClassLocation.new(class_location_params)

    respond_to do |format|
      if @class_location.save
        format.html { redirect_to @class_location, notice: 'Class location was successfully created.' }
        format.json { render :show, status: :created, location: @class_location }
      else
        format.html { render :new }
        format.json { render json: @class_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /class_locations/1
  # PATCH/PUT /class_locations/1.json
  def update
    respond_to do |format|
      if @class_location.update(class_location_params)
        format.html { redirect_to @class_location, notice: 'Class location was successfully updated.' }
        format.json { render :show, status: :ok, location: @class_location }
      else
        format.html { render :edit }
        format.json { render json: @class_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_locations/1
  # DELETE /class_locations/1.json
  def destroy
    @class_location.destroy
    respond_to do |format|
      format.html { redirect_to class_locations_url, notice: 'Class location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_class_location
      @class_location = ClassLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def class_location_params
      params.require(:class_location).permit(:name, :email, :timezone)
    end
end
