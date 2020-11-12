class DepartamentosController < ApplicationController
  before_action :set_departamento, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :is_admin

  def index
    @departamentos = Departamento.activos
    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
    end
  end

  def new
    @departamento = Departamento.new
  end

  def edit
  end

  def show
  end

  def create
    @departamento = Departamento.new(departamento_params)
    @departamento.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @departamento.save
        AuditoriaDataAccess.log current_user, Auditoria::ALTA, Auditoria::DEPARTAMENTO, @departamento
        format.html { redirect_to departamentos_url, notice: I18n.t('common.exito.creacion_departamento') }
        format.json { render :show, status: :created, location: @departamento }
        format.js { render :show, status: :created, location: @departamento }
      else
        format.html { render :new }
        format.json { render json: @departamento.errors, status: :unprocessable_entity }
        format.js   { render json: @departamento.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @departamento.update(departamento_params)
        AuditoriaDataAccess.log current_user, Auditoria::MODIFICACION, Auditoria::DEPARTAMENTO, @departamento
        format.html { redirect_to departamentos_url, notice: I18n.t('common.exito.actualizacion_departamento') }
        format.json { render :show, status: :ok, location: @departamento }
      else
        format.html { render :edit }
        format.json { render json: @departamento.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    DepartamentoDataAccess.borrar_logico(@departamento, current_user)
    respond_to do |format|
      format.html { redirect_to departamentos_url, notice: I18n.t('common.exito.borrado_departamento') }
      format.json { head :no_content }
    end
  end

  protected

    def resource_not_found
      message = I18n.t('errors.messages.not_found', prefix: 'El', resource: 'área')
      flash[:alert] = message
      redirect_to root_path
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departamento
      @departamento = Departamento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def departamento_params
      params.require(:departamento).permit(:nombre)
    end
end
