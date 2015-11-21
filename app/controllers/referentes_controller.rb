class ReferentesController < ApplicationController
  before_action :set_referente, only: [:show, :edit, :update, :destroy]

  # GET /referentes
  # GET /referentes.json
  def index
    @referentes = Referente.all
  end

  # GET /referentes/1
  # GET /referentes/1.json
  def show
  end

  # GET /referentes/new
  def new
    @referente = Referente.new
  end

  # GET /referentes/1/edit
  def edit
  end

  # POST /referentes
  # POST /referentes.json
  def create
    @referente = Referente.new(referente_params)

    respond_to do |format|
      if @referente.save
        format.html { redirect_to referentes_url, notice: 'Referente creado correctamente.' }
        format.json { render :show, status: :created, location: @referente }
      else
        format.html { render :new }
        format.json { render json: @referente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referentes/1
  # PATCH/PUT /referentes/1.json
  def update
    respond_to do |format|
      if @referente.update(referente_params)
        format.html { redirect_to referentes_url, notice: 'Referente actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @referente }
      else
        format.html { render :edit }
        format.json { render json: @referente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referentes/1
  # DELETE /referentes/1.json
  def destroy
    @referente.destroy
    respond_to do |format|
      format.html { redirect_to referentes_url, notice: 'Referente borrado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referente
      @referente = Referente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def referente_params
      params.require(:referente).permit(:nombre, :apellido, :telefono, :area_id, :dia)
    end
end
