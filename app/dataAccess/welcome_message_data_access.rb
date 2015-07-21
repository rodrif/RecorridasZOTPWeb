class WelcomeMessageDataAccess

	def self.getCurrentMessage 
	
	  WelcomeMessage.readonly.select(:id, :mensaje).where('fecha_desde <= ? AND fecha_hasta >= ?', Time.now, Time.now)
	  	.order("fecha_desde DESC").take(1);

	end
end