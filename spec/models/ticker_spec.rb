require 'rails_helper'

describe Ticker do
  it 'has a valid factory' do
    expect(build(:ticker)).to be_valid
  end
end
