require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'validations' do
    it { should validate_uniqueness_of :uid }
  end

  describe 'methods' do
    describe '#registered_symbols' do
      context 'with sheet is blank' do
        it 'is expected to return nil' do
          user = create(:portfolio, :blank_sheet).user
          expect(user.registered_symbols).to be_nil
        end
      end
      context 'with sheet is not blank' do
        it 'is expected not to return nil' do
          user = create(:portfolio).user
          expect(user.registered_symbols).not_to be_nil
        end
      end
    end
  end
end
