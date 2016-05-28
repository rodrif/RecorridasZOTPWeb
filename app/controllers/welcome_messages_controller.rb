class WelcomeMessagesController < ApplicationController
  before_action :set_welcome_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :puede_ver_web

  def mobGetMensajeBienvenida
    welcomeMessage = WelcomeMessageDataAccess.getCurrentMessage
    render :json => welcomeMessage.to_json
  end

  # GET /welcome_messages
  # GET /welcome_messages.json
  def index
    @welcome_messages = WelcomeMessage.all
  end

  # GET /welcome_messages/1
  # GET /welcome_messages/1.json
  def show
  end

  # GET /welcome_messages/new
  def new
    @welcome_message = WelcomeMessage.new
  end

  # GET /welcome_messages/1/edit
  def edit
  end

  # POST /welcome_messages
  # POST /welcome_messages.json
  def create
    @welcome_message = WelcomeMessage.new(welcome_message_params)

    respond_to do |format|
      if @welcome_message.save
        format.html { redirect_to @welcome_message, notice: 'Welcome message was successfully created.' }
        format.json { render :show, status: :created, location: @welcome_message }
      else
        format.html { render :new }
        format.json { render json: @welcome_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /welcome_messages/1
  # PATCH/PUT /welcome_messages/1.json
  def update
    respond_to do |format|
      if @welcome_message.update(welcome_message_params)
        format.html { redirect_to @welcome_message, notice: 'Welcome message was successfully updated.' }
        format.json { render :show, status: :ok, location: @welcome_message }
      else
        format.html { render :edit }
        format.json { render json: @welcome_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /welcome_messages/1
  # DELETE /welcome_messages/1.json
  def destroy
    @welcome_message.destroy
    respond_to do |format|
      format.html { redirect_to welcome_messages_url, notice: 'Welcome message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_welcome_message
      @welcome_message = WelcomeMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def welcome_message_params
      params.require(:welcome_message).permit(:mensaje, :fecha_desde, :fecha_hasta, :person_id)
    end
end
