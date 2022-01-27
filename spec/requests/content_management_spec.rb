# frozen_string_literal: true

require 'rails_helper'

describe 'Content Management' do
  let(:admin)  { create(:user, :admin) }
  let(:course) { create(:course) }
  context 'POST /api/v1/courses/:course_id/contents' do
    it 'admins can add course content' do
      post "/api/v1/courses/#{course.id}/contents",
           as: :json,
           headers: authenticate_header(admin),
           params: { file: fixture_file_upload('dramatic_chipmunk.mp4',
                                               'video/mp4'),
                     name: 'First lesson' }

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:name]).to eq('First lesson')
      expect(parsed_body[:course_id]).to eq(course.id)
    end

    it 'content should be validated' do
      post '/api/v1/courses/000/contents',
           as: :json,
           headers: authenticate_header(admin),
           params: { content: { something: '' } }

      expect(response).to have_http_status(422)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:message]).to eq(
        "Validation failed: Course must exist, Name can't be blank"
      )
    end

    it 'content should receive params' do
      post '/api/v1/courses/000/contents',
           as: :json,
           headers: authenticate_header(admin),
           params: {}

      expect(response).to have_http_status(400)
      expect(response.content_type).to include('application/json')
      expect(parsed_body[:message]).to eq(
        'Parameters necessary for this request could not be found'
      )
    end

    it 'should have ACCEPT header' do
      expect { post "/api/v1/courses/#{course.id}/contents" }
        .to raise_error(ActionController::RoutingError)
    end

    it 'Only users logged in could access route' do
      post "/api/v1/courses/#{course.id}/contents", as: :json

      expect(response).to have_http_status(401)
    end

    it 'Only admins could access route' do
      post "/api/v1/courses/#{course.id}/contents", as: :json,
                                                    headers: authenticate_header

      expect(response).to have_http_status(403)
    end
  end

  context 'DELETE /api/v1/contents/:id' do
    let(:content) { create(:content) }
    it 'admins can remove content' do
      delete "/api/v1/contents/#{content.id}",
             as: :json,
             headers: authenticate_header(admin)

      expect(response).to have_http_status(204)
    end

    it 'should have ACCEPT header' do
      expect { delete "/api/v1/contents/#{content.id}" }
        .to raise_error(ActionController::RoutingError)
    end

    it 'Only users logged in could access route' do
      delete "/api/v1/contents/#{content.id}", as: :json

      expect(response).to have_http_status(401)
    end

    it 'Only admins could access route' do
      delete "/api/v1/contents/#{content.id}", as: :json,
                                               headers: authenticate_header

      expect(response).to have_http_status(403)
    end
  end
end
