
require 'rails_helper'

RSpec.describe Lens, type: :model do
  describe "associations" do
    it { should belong_to(:glasses) }
  end

  describe "validations" do
    it { should validate_presence_of(:colour) }
    it { should validate_presence_of(:stock) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:currency) }
    it { should validate_uniqueness_of(:price).scoped_to(:currency) }
    it do
      should validate_inclusion_of(:currency).
      in_array(%w(USD GBP EUR JOD JPY)).
      with_message("must be one of: USD, GBP, EUR, JOD, JPY")
    end
  end

  describe "enums" do
    it do
      should define_enum_for(:prescription_type).
      with_values(fashion: 0, single_vision: 1, varifocal: 2)
    end

    it do
      should define_enum_for(:lens_type).
      with_values(classic: 0, blue_light: 1, transition: 2)
    end
  end
end
