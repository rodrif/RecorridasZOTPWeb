RSpec.shared_examples "response ok" do
  it "devuelve recurso satisfactoriamente" do
    expect(response.status).to eq 200
  end
end

RSpec.shared_examples "response no token" do
  it "devuelve 401 y mensaje de inicio de sesión" do
    expect(response.status).to eq 401
    json = JSON.parse(response.body)
    expect(json["errors"]).to include("Necesitas iniciar sesión o registrarte para continuar.")
  end
end

RSpec.shared_examples "response access denied" do
  it "devuelve 401 y mensaje de acceso denegado" do
    expect(response.status).to eq 401
    json = JSON.parse(response.body)
    expect(json["errores"]).to include("acceso denegado")
  end
end
