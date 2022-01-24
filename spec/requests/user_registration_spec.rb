# frozen_string_literal: true

require 'rails_helper'

describe 'User Registration' do
  it 'creates user and return token' do
    user = build(:user)
    allow(User).to receive(:new).and_return(user)

    post '/api/sign_up',
         params: { email: user.email, password: user.password, name: user.name },
         as: :json

    expect(response).to have_http_status(201)
    expect(user.reload).to be_persisted
    expect(parsed_body[:token]).to be_present
  end

  it 'without email do not create' do
    user = build(:user)

    post '/api/sign_up',
         params: { password: user.password, name: user.name },
         as: :json

    expect(response).to have_http_status(422)
    expect(parsed_body.keys).to contain_exactly(:email)
    expect(parsed_body[:email]).to contain_exactly("can't be blank")
  end

  it 'with invalid email do not create' do
    user = build(:user)

    post '/api/sign_up',
         params: { email: 'aaa@', password: user.password, name: user.name },
         as: :json

    expect(response).to have_http_status(422)
    expect(parsed_body.keys).to contain_exactly(:email)
    expect(parsed_body[:email]).to contain_exactly('is invalid')
  end

  it 'without password do not create' do
    user = build(:user)

    post '/api/sign_up',
         params: { email: user.email, name: user.name },
         as: :json

    expect(response).to have_http_status(422)
    expect(parsed_body.keys).to contain_exactly(:password)
    expect(parsed_body[:password]).to contain_exactly("can't be blank")
  end

  it 'with small password do not create' do
    user = build(:user)

    post '/api/sign_up',
         params: { email: user.email, password: '123', name: user.name },
         as: :json

    expect(response).to have_http_status(422)
    expect(parsed_body.keys).to contain_exactly(:password)
    expect(parsed_body[:password])
      .to contain_exactly('is too short (minimum is 6 characters)')
  end

  it 'without name do not create' do
    user = build(:user)

    post '/api/sign_up',
         params: { email: user.email, password: user.password },
         as: :json

    expect(response).to have_http_status(422)
    expect(parsed_body.keys).to contain_exactly(:name)
    expect(parsed_body[:name]).to contain_exactly("can't be blank")
  end
end
