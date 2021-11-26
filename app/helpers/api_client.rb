class ApiClient
  def self.post(path, body)
    response = Faraday.post("http://localhost:4000/api/v1/#{path}/", body, 'Content-Type' => 'application/json')

    return nil unless response.status == 201

    JSON.parse(response.body, symbolize_names: true)
  rescue Faraday::ConnectionFailed
    { error: { message: 'Falha na conexão com API externa' } }
  end
end
