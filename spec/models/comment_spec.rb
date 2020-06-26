require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :user }

  describe 'factory' do
    it 'should be valid' do
      expect(create(:comment)).to be_valid
    end
  end
end
