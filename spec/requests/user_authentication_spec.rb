# frozen_string_literal: true

require 'rails_helper'

describe 'User Authentication' do
  context 'sign in' do
    it 'returns a token for api call' do
      user = create(:user)

      post '/api/sign_in',
        params: { email: user.email, password: user.password },
        as: :json


      expect(response).to have_http_status(200)
      expect(parsed_body[:token]).to be_present
    end

    it 'returns 404 when user not found' do
      post '/api/sign_in',
        params: { email: 'test@email.com', password: '123456'},
        as: :json


      expect(response).to have_http_status(404)
      expect(parsed_body[:message]).to eq('User could not be found')
    end
  end
end
