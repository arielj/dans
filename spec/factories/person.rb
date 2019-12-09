FactoryBot.define do
  factory :person do
    name { 'Jon' }
    lastname { 'Doe' }
    status { Person.statuses.keys.sample }
    gender { Person.genders.keys.sample }
  end
end
