class MapaController < ApplicationController

	def index
	end

	def mostrar
		@personas = PersonDataAccess.listPersonaMapa
	end
end
