FactoryBot.define do
  factory :klass do
    sequence(:name) { |n| "Klass #{n}" }
    fixed_fee_cents { '50000' }
    fixed_fee_with_discount_cents { '40000' }

    factory :klass_with_schedules do
      after(:build) do |k|
        k.schedules << FactoryBot.build(:schedule, from_time: '12:30', to_time: '13:30')
        k.schedules << FactoryBot.build(:schedule, from_time: '13:30', to_time: '14:30')
      end
    end

    factory :klass_with_one_schedule do
      after(:build) do |k|
        k.schedules << FactoryBot.build(:schedule, from_time: '12:30', to_time: '13:30')
      end
    end
  end
end
