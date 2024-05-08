
require 'rails_helper'

RSpec.describe Glass, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:frame) }
    it { should belong_to(:lens) }
  end
end
