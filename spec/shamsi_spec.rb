require 'spec_helper'

RSpec.describe Shamsi do
  it 'has a version number' do
    expect(Shamsi::VERSION).not_to be nil
  end

  it 'converts georgean to jalali' do
    georgian_date = Date.new(1992, 1, 1)
    jalali_date = Shamsi::Date.new(georgian_date)
    expect(jalali_date.year).to be 1370
    expect(jalali_date.month).to be 10
    expect(jalali_date.day).to be 11
  end

end
