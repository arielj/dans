# typed: false
FactoryBot.define do
  factory :klass do
    sequence(:name) { |n| "Klass #{n}" }
    fixed_fee_cents { '50000' }

    factory :klass_with_schedules do
      after(:build) do |k|
        k.schedules << FactoryBot.build(:schedule, from_time: '12:30', to_time: '13:30')
        k.schedules << FactoryBot.build(:schedule, from_time: '13:30', to_time: '14:30')
        k.schedules << FactoryBot.build(:schedule, from_time: '14:30', to_time: '15:30')
      end
    end
  end
end
