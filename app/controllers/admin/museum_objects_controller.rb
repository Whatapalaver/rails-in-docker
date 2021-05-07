class Admin::MuseumObjectsController < ApplicationController
  before_action :set_museum_object, only: %i[ show edit update destroy ]

  # GET /museum_objects or /museum_objects.json
  def index
    @museum_objects = MuseumObject.all
  end

  # GET /museum_objects/1 or /museum_objects/1.json
  def show
  end


  # GET /museum_objects/new
  def new
    @museum_object = MuseumObject.new.tap do |mo|
      mo.attributes = {
        systemNumber: params[:systemNumber],
        objectType: params[:objectType],
        title: params[:_primaryTitle],
        image_id: params[:_primaryImageId],
        description: ''
      }
    end
  end

  # GET /museum_objects/1/edit
  def edit
  end

  # POST /museum_objects or /museum_objects.json
  def create
    @museum_object = MuseumObject.new(museum_object_params)

    if @museum_object.save
      redirect_to admin_museum_object_path(@museum_object), notice: "Museum object was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /museum_objects/1

  def update
      if @museum_object.update(museum_object_params)
        redirect_to admin_museum_object_path(@museum_object), notice: "Museum object was successfully updated." 
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /museum_objects/1
  def destroy
    @museum_object.destroy
    redirect_to admin_museum_objects_url, notice: "Museum object was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_museum_object
      @museum_object = MuseumObject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def museum_object_params
      params.require(:museum_object).permit(:systemNumber, :objectType, :title, :image_id, :description)
    end

end
