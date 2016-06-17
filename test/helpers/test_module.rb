module TestModule

  def jsonComp paramId, id, parametro
    json.find { |p| p[paramId] == id }[parametro]
  end

  def json
    ActiveSupport::JSON.decode @response.body
  end
  
end