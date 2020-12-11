def expect_ok path, flash_message
  expect(response).to redirect_to(path)
  expect(response.status).to eq 302
  expect(flash[:notice]).to eq flash_message
end


RSpec.shared_examples "not logged in user" do
  it "redirecciona a página de sign in" do
    expect(response.status).to eq 302
    flash_message = "Necesitas iniciar sesión o registrarte para continuar."
    expect(flash[:alert]).to eq flash_message
  end
end

RSpec.shared_examples "get ok" do
  it "muestra recurso satisfactoriamente" do
    expect(response.status).to eq 200
  end
end

RSpec.shared_examples "post ok" do
  it "crea recurso correctamente y redirecciona a página de recursos" do
    expect_ok path, flash_message
  end
end

RSpec.shared_examples "put ok" do
  it "actualiza recurso correctamente y redirecciona a página de recursos" do
    expect_ok path, flash_message
  end
end

RSpec.shared_examples "delete ok" do
  it "borra recurso correctamente y redirecciona a página de recursos" do
    expect_ok path, flash_message
  end
end

RSpec.shared_examples "access denied" do
  it "redirecciona a la página de acceso denegado" do
    expect(response).to redirect_to(acceso_denegado_path)
    expect(response.status).to eq 302
  end
end

RSpec.shared_examples "not found" do
  it "muestra mensaje de recurso no encontrado" do
    expect(response.status).to eq 302
    expect(flash[:alert]).to eq "#{resource} no se ha podido encontrar."
  end
end

