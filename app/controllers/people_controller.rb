class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def mobGuardarPersonasPost
    respuesta = PersonDataAccess.guardarPersonasFromJson params['datos'], params['fecha']

    render :json => respuesta
  end

  def mobRecibirPersonasDesde    
    respuesta = PersonDataAccess.getPersonasDesde params['datos'], params['fecha']

    render :json => respuesta
  end

  # GET /people
  # GET /people.json
  def index
    #@people = Person.all

    @filterrific = initialize_filterrific(
      Person,
      params[:filterrific],
      select_options: {   
        with_zone_id: Zone.options_for_select
      },
      default_filter_params: {}
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    # @people = @filterrific.find.page(params[:page])
    @people = @filterrific.find

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end

    # # Recover from invalid param sets, e.g., when a filter refers to the
    # # database id of a record that doesn’t exist any more.
    # # In this case we reset filterrific and discard all filter params.
    # rescue ActiveRecord::RecordNotFound => e
    #   # There is an issue with the persisted param_set. Reset it.
    #   puts "Had to reset filterrific params: #{ e.message }"
    #   redirect_to(reset_filterrific_url(format: :html)) and return
    # end
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @person.state = State.find_by_nombre('Actualizado');

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    #@person.destroy
    @person.state_id = 3
    @person.save
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:nombre, :apellido, :zone_id)
    end
end
