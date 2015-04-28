class AlertDataAccess

	def self.listAlertas fecha, zona = nil, alertType = nil

	  Alert.readonly.find_by_sql(
	  	["SELECT a.id AS idAlerta, z.nombre AS nombreZona,
	  	at.nombre as nombreAlertaTipo, a.fecha, a.mensaje
	  	FROM alerts a
	  	LEFT JOIN alert_types at on a.alert_type_id = at.id
	  	LEFT JOIN zones z on a.zone_id = z.id
	  	WHERE a.fecha >= :fecha
	  	AND (:zona IS NULL OR z.nombre = :zona )
	  	AND (:alertType IS NULL OR at.nombre = :alertType)",
	  	{ :fecha => fecha, :zona => zona, :alertType => alertType }])
	end

end