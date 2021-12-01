class ApiPagapaga
  API_ENDPOINT = Rails.configuration.api_pagapaga[:endpoint]
  API_COMPANY_TOKEN = Rails.configuration.api_pagapaga[:company_token]

  def self.post(path, body, header = {})
    header = header.merge({ 'Content-Type' => 'application/json', 'company_token' => API_COMPANY_TOKEN })
    response = Faraday.post("#{API_ENDPOINT}/api/v1/#{path}/", body, header)

    return { message: I18n.t('messages.api_server_error') } if response.status == 500

    return { message: I18n.t('messages.api_standard_error') } unless response.status == 201

    JSON.parse(response.body, symbolize_names: true)
  rescue Faraday::ConnectionFailed
    { message: I18n.t('messages.api_connection_error') }
  rescue StandardError
    { message: I18n.t('messages.api_standard_error') }
  end

  def self.get(path, params = {}, header = {})
    header = header.merge({ 'Content-Type' => 'application/json', 'company_token' => API_COMPANY_TOKEN })
    response = Faraday.get("#{API_ENDPOINT}/api/v1/#{path}/", params, header)

    return { message: I18n.t('messages.api_server_error') } if response.status == 500

    return { message: I18n.t('messages.api_standard_error') } unless response.status == 200

    return [] if response.body.empty?

    JSON.parse(response.body, symbolize_names: true)
  rescue Faraday::ConnectionFailed
    { message: I18n.t('messages.api_connection_error') }
  rescue StandardError
    { message: I18n.t('messages.api_standard_error') }
  end
end
