# typed: false
FactoryBot.define do
  factory :klass do
    sequence(:name) { |n| "Klass #{n}" }
    fixed_fee_cents { '50000' }

    factory :klass_with_schedules do
      after(:build) do |k|
        3.times { k.schedules << FactoryBot.build(:schedule) }
      end
    end
  end
end
