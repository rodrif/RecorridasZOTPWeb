class EventosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_evento, only: [:show, :edit, :update, :destroy]

  # GET /eventos
  # GET /eventos.json
  def index
    @eventos = current_user.eventos.all
  end

  # GET /eventos/1
  # GET /eventos/1.json
  def show
  end

  # GET /eventos/new
  def new
    @evento = Evento.new
    if params['date']
      @evento.fecha_desde = params['date']
      @evento.fecha_hasta = params['date']
    end
  end

  # GET /eventos/1/edit
  def edit
  end

  # POST /eventos
  # POST /eventos.json
  def create
    @evento = Evento.new(evento_params)
    @evento.user = current_user

    respond_to do |format|
      if @evento.save
        Notificacion.schedule(@evento.titulo, @evento.person.full_name, @evento.fecha_desde, @evento.fecha_hasta, @evento.fecha_desde.advance(hours: -1), [current_user.area.id], [1,2,3,4], @evento)
        format.html { redirect_to @evento, notice: 'Evento creado correctamente.' }
        format.json { render :show, status: :created, location: @evento }
      else
        format.html { render :new }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eventos/1
  # PATCH/PUT /eventos/1.json
  def update
    respond_to do |format|
      if @evento.update(evento_params)
        format.html { redirect_to @evento, notice: 'Evento actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @evento }
      else
        format.html { render :edit }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /eventos/1
  # DELETE /eventos/1.json
  def destroy
    @evento.destroy
    respond_to do |format|
      format.html { redirect_to eventos_url, notice: 'Evento borrado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evento
      @evento = Evento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evento_params
      params.require(:evento).permit(:titulo, :descripcion, :fecha_desde, :fecha_hasta, :ubicacion, :person_id, :user_id)
    end
end
