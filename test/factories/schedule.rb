# typed: false
FactoryBot.define do
  factory :schedule do
    from_time { '12:30' }
    to_time { '14:30' }
    day { 1 }
    association :room, factory: :room
    association :klass, factory: :klass
  end
end
