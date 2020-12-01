require 'rails_helper'
RSpec.feature "Listar eventos" do

  before do
    @voluntario = create(:user_voluntario)
    @voluntario2 = create(:user_voluntario)
  end

  let!(:persona) { create(:person) }
  let!(:evento) { create(:evento, person: persona, user: @voluntario)}
  let!(:evento2) { create(:evento, person: persona, user: @voluntario2)}

  scenario "solo lista los eventos del usuario actaul" do
    login_as @voluntario
    visit eventos_path

    expect(page).to have_content(evento.titulo)
    expect(page).not_to have_content(evento2.titulo)
  end
end