# typed: false
require 'rails_helper'

describe 'Installment' do
  it 'requires a year' do
    ins = build(:installment, year: nil)
    expect(ins).to be_invalid
    expect(ins.errors[:year]).to be_present

    ins.year = 2020
    expect(ins).to be_valid
  end

  it 'requries a month' do
    ins = build(:installment, month: nil)
    expect(ins).to be_invalid
    expect(ins.errors[:month]).to be_present

    ins.month = :february
    expect(ins).to be_valid
  end
end
