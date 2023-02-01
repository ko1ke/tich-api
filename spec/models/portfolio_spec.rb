require 'rails_helper'

describe Portfolio do
  it 'has a valid factory' do
    expect(build(:portfolio)).to be_valid
  end
end
