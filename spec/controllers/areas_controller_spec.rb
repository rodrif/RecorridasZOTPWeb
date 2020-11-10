require 'rails_helper'

RSpec.describe AreasController, type: :controller do
  login_admin

  describe "GET /areas" do
    context "when having multiple areas" do
      before do
        create(:state, :activo)
        create_list(:area, 1)
      end

      it "returns all of them" do
        visit areas_path
        sleep(5)
        expect(page).to have_content("Areas")
      end
    end
  end
end
