FactoryBot.define do
  factory :membership do
    amount_cents { 100_00 }
    amount_with_discount_cents { 90_00 }
    association :person
    status { Membership.statuses.keys.sample }
  end
end
