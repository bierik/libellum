if Rails.env.test?
  require Rails.root + 'test/support/google_maps_mock'
  Rails.application.config.google_maps_service = GoogleMapsMock
else
  Google::Maps.configure do |config|
    config.authentication_mode = Google::Maps::Configuration::API_KEY
    config.api_key = Rails.application.credentials.dig(:google_maps, :apikey)
    config.default_language = :de
  end
  Rails.application.config.google_maps_service = Google::Maps::Route
end
