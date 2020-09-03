# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_length_of(:title).is_at_least(3).is_at_most(100) }

    it { should validate_presence_of :description }

    it { should validate_presence_of :slug }
    it { should validate_length_of(:slug).is_at_least(3).is_at_most(100) }
  end
end
