class MapaController < ApplicationController

	def index
		@personas = PersonDataAccess.listPersonaMapa
	end

	def mostrar
		@personas = PersonDataAccess.listPersonaMapa
	end
end
