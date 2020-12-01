require 'rails_helper'

RSpec.describe "Eventos", type: :request do
  describe "GET /eventos" do
    it "works! (now write some real specs)" do
      get eventos_path
      expect(response).to have_http_status(200)
    end
  end
end
