class FamiliasController < ApplicationController
  before_action :set_familia, only: [:show, :edit, :update, :destroy]

  # GET /familias
  # GET /familias.json
  def index
    @familias = Familia.all
  end

  # GET /familias/1
  # GET /familias/1.json
  def show
  end

  # GET /familias/new
  def new
    @familia = Familia.new
  end

  # GET /familias/1/edit
  def edit
  end

  # POST /familias
  # POST /familias.json
  def create
    @familia = Familia.new(familia_params)

    respond_to do |format|
      if @familia.save
        format.html { redirect_to @familia, notice: 'Familia was successfully created.' }
        format.json { render :show, status: :created, location: @familia }
        format.js { render :show, status: :created, location: @familia }
      else
        format.html { render :new }
        format.json { render json: @familia.errors, status: :unprocessable_entity }
        format.js   { render json: @familia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /familias/1
  # PATCH/PUT /familias/1.json
  def update
    respond_to do |format|
      if @familia.update(familia_params)
        format.html { redirect_to @familia, notice: 'Familia was successfully updated.' }
        format.json { render :show, status: :ok, location: @familia }
      else
        format.html { render :edit }
        format.json { render json: @familia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /familias/1
  # DELETE /familias/1.json
  def destroy
    @familia.destroy
    respond_to do |format|
      format.html { redirect_to familias_url, notice: 'Familia was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_familia
      @familia = Familia.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def familia_params
      params.require(:familia).permit(:nombre, :area_id, :zone_id, :ranchada_id, :descripcion)
    end
end
