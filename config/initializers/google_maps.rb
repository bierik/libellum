Rails.application.config.google_maps_service = GoogleMapsService::Client.new(key: ENV['GOOGLE_MAPS_API_KEY'])
