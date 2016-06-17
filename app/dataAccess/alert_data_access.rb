class AlertDataAccess

	def self.listAlertas fecha, zona = nil, alertType = nil

	  Alert.readonly.find_by_sql(
	  	["SELECT a.id AS alerta_id, z.nombre AS nombre_zona,
	  	at.nombre as nombre_alerta_tipo, a.fecha, a.mensaje
	  	FROM alerts a
	  	LEFT JOIN alert_types at on a.alert_type_id = at.id
	  	LEFT JOIN zones z on a.zone_id = z.id
	  	WHERE a.fecha >= :fecha
	  	AND (:zona IS NULL OR z.nombre = :zona )
	  	AND (:alertType IS NULL OR at.nombre = :alertType)",
	  	{ :fecha => fecha, :zona => zona, :alertType => alertType }])
	end

end