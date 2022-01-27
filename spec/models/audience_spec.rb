# frozen_string_literal: true

require 'rails_helper'

describe Audience do
  subject { build(:audience) }
  it { should belong_to :user }
  it { should belong_to :course }
  it do
    should validate_uniqueness_of(:course_id)
      .scoped_to(:user_id)
      .ignoring_case_sensitivity
  end
end
