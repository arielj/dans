# typed: false
FactoryBot.define do
  factory :installment do
    association :membership
    association :person
    month { Installment.months.keys.sample }
    year { 2020 }
  end
end
