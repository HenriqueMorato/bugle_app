# frozen_string_literal: true

require 'rails_helper'

describe Content do
  it { should belong_to :course }
  it { should belong_to :user }
  it { should have_one_attached :file }

  context 'validations' do
    it { should validate_presence_of :name }

    it 'video must be a video' do
      content = build(:content)
      content.file.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/sample_image.jpg')),
        filename: 'sample_image.jpg',
        content_type: 'image/jpeg'
      )
      content.save
      expect(content.errors.full_messages).to match_array(
        'File has an invalid content type'
      )
    end
  end

  context '#file_url' do
    it 'generate a link' do
      content = build(:content)
      content.file.attach(
        io: File.open(Rails.root.join('spec/fixtures/files/sample_image.jpg')),
        filename: 'sample_image.jpg',
        content_type: 'image/jpeg'
      )
      content.save
      expect(content.file_url).to include('http://')
    end
  end
end
