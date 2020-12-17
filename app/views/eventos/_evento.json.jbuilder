json.id event.id
json.titulo event.titulo
json.descripcion event.descripcion
json.fecha_desde event.fecha_desde
json.fecha_hasta event.fecha_hasta

json.update_url evento_path(event, method: :patch)
json.edit_url edit_evento_path(event)