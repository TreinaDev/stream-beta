require 'rails_helper'

describe 'ApiPagapaga' do
  context '.post' do
    context 'when it returns status_code' do
      it '201' do
        fake_body = '{"title":"Teste ABC","value":10}'
        fake_response = instance_double(Faraday::Response, status: 201, body: fake_body)
        allow(Faraday).to receive(:post).and_return(fake_response)

        data = ApiPagapaga.post('', '')

        expect(data).to_not include(:message)
        expect(data).to eq({ title: 'Teste ABC', value: 10 })
      end

      it '500' do
        fake_response = instance_double(Faraday::Response, status: 500)
        allow(Faraday).to receive(:post).and_return(fake_response)

        data = ApiPagapaga.post('', '')

        expect(data).to include(:message)
        expect(data[:message]).to eq('Ocorreu um erro no servidor externo')
      end

      it 'Other status' do
        fake_response = instance_double(Faraday::Response, status: 999)
        allow(Faraday).to receive(:post).and_return(fake_response)

        data = ApiPagapaga.post('', '')

        expect(data).to include(:message)
        expect(data[:message]).to eq('Ocorreu um erro')
      end
    end

    context 'when it raises exception' do
      it 'Faraday::ConnectionFailed' do
        faraday = class_double(Faraday)
        allow(faraday).to receive(:post).and_raise(Faraday::ConnectionFailed)

        data = ApiPagapaga.post('', '')

        expect(data).to include(:message)
        expect(data[:message]).to eq('Não foi possível estabelecer conexão com a plataforma de pagamentos')
      end

      it 'StandardError' do
        allow(Faraday).to receive(:post).and_raise(StandardError)

        data = ApiPagapaga.post('', '')

        expect(data).to include(:message)
        expect(data[:message]).to eq('Ocorreu um erro')
      end
    end
  end
end
