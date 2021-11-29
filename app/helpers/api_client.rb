class ApiClient
  def self.post(path, body)
    response = Faraday.post("http://localhost:4000/api/v1/#{path}/", body, 'Content-Type' => 'application/json')

    return { message: I18n.t('messages.api_server_error') } if response.status == 500

    return { message: I18n.t('messages.api_standard_error') } unless response.status == 201

    JSON.parse(response.body, symbolize_names: true)
  rescue Faraday::ConnectionFailed
    { message: I18n.t('messages.api_connection_error') }
  rescue StandardError
    { message: I18n.t('messages.api_standard_error') }
  end
end
