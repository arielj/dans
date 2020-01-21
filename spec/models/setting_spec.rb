# typed: false
require 'rails_helper'

describe 'Setting' do
  it 'sets and gets hours fees' do
    Setting.set_hours_fee 0.5, 300
    Setting.set_hours_fee 1.0, 400
    Setting.set_hours_fee 2, 500

    expect(Setting.get_hours_fee(0.5)).to eq 300
    expect(Setting.get_hours_fee(1)).to eq 400
    expect(Setting.get_hours_fee(2.0)).to eq 500
  end
end
