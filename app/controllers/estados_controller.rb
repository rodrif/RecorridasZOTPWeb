class EstadosController < ApplicationController
  before_action :set_estado, only: [:show, :edit, :update, :destroy]
  before_action :puede_editar_estado

  def index
    @estados = Estado.activos
    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
    end
  end

  def new
    @estado = Estado.new
  end

  def edit
  end

  def show
  end

  def create
    @estado = Estado.new(estado_params)
    @estado.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @estado.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::ESTADO, @estado
        format.html { redirect_to estados_url, notice: I18n.t('common.exito.creacion_estado') }
        format.json { render :show, status: :created, location: @estado }
        format.js { render :show, status: :created, location: @estado }
      else
        format.html { render :new }
        format.json { render json: @estado.errors, status: :unprocessable_entity }
        format.js   { render json: @estado.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @estado.update(estado_params)
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::ESTADO, @estado
        format.html { redirect_to estados_url, notice: I18n.t('common.exito.actualizacion_estado') }
        format.json { render :show, status: :ok, location: @estado }
      else
        format.html { render :edit }
        format.json { render json: @estado.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    EstadoDataAccess.borrar_logico(@estado, current_user)
    respond_to do |format|
      format.html { redirect_to estados_url, notice: I18n.t('common.exito.borrado_estado') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estado
      @estado = Estado.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def estado_params
      params.require(:estado).permit(:nombre)
    end
end
