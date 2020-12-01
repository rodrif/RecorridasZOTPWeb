require "rails_helper"

RSpec.describe EventosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/eventos").to route_to("eventos#index")
    end

    it "routes to #new" do
      expect(:get => "/eventos/new").to route_to("eventos#new")
    end

    it "routes to #show" do
      expect(:get => "/eventos/1").to route_to("eventos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/eventos/1/edit").to route_to("eventos#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/eventos").to route_to("eventos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/eventos/1").to route_to("eventos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/eventos/1").to route_to("eventos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/eventos/1").to route_to("eventos#destroy", :id => "1")
    end
  end
end
