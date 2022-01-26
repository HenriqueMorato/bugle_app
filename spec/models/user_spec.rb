# frozen_string_literal: true

require 'rails_helper'

describe User do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should allow_values(:user, :admin).for(:role) }
    it do
      should define_enum_for(:role)
        .with_values(user: 'user', admin: 'admin')
        .with_suffix
        .backed_by_column_of_type(:enum)
    end

    it 'has a default user role' do
      expect(subject).to be_user_role
    end
  end
end
