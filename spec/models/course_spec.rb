# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_length_of(:title).is_at_least(3).is_at_most(100) }

    it { is_expected.to validate_presence_of :description }

    it { is_expected.to validate_presence_of :slug }
    it { is_expected.to validate_length_of(:slug).is_at_least(3).is_at_most(100) }
    it { is_expected.to validate_uniqueness_of(:slug).case_insensitive }
  end
end
