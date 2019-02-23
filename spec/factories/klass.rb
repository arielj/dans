FactoryBot.define do
  factory :klass do
    sequence(:name) {|n| "Klass #{n}" }
    fixed_fee_cents {'50000'}
  end
end
