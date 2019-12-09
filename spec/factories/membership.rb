FactoryBot.define do
  factory :membership do
    amount_cents { 10_000 }
    association :person
    status { Membership.statuses.keys.sample }
  end
end
