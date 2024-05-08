
require 'rails_helper'

RSpec.describe Frame, type: :model do
  subject { described_class.new }

  describe "associations" do
    it { should have_many(:glasses) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:stock) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:currency) }
    it { should validate_uniqueness_of(:price).scoped_to(:currency) }
    it { should validate_inclusion_of(:currency).in_array(%w(USD GBP EUR JOD JPY)).with_message("must be one of: USD, GBP, EUR, JOD, JPY") }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values({ inactive: 0, active: 1 }) }
  end
end
