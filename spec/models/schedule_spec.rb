# typed: false
require 'rails_helper'

describe 'Schedule' do
  describe '#duration' do
    it 'returns the schedule duration as decimal value' do
      sc = build :schedule, from_time: '10:30', to_time: '12:30'
      expect(sc.duration).to eq 2

      sc = build :schedule, from_time: '11:30', to_time: '12:00'
      expect(sc.duration).to eq 0.5

      sc = build :schedule, from_time: '10:00', to_time: '11:30'
      expect(sc.duration).to eq 1.5

      sc = build :schedule, from_time: '10:45', to_time: '12:00'
      expect(sc.duration).to eq 1.25
    end
  end

  describe '#to_label' do
    it 'interpolates the correct label' do
      sc = build :schedule, from_time: '10:30', to_time: '12:30', day: 0
      expect(sc.to_label).to eq "#{sc.klass.name}: 10:30-12:30"
    end
  end
end
