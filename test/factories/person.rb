# typed: false
# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    name { 'Jon' }
    lastname { 'Doe' }
    status { :active }
    gender { Person.genders.keys.sample }

    factory :student do
      is_teacher { false }
    end

    factory :teacher do
      is_teacher { true }
    end
  end
end
