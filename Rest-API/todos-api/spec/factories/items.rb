FactoryBot.define do
    factory :item do
      name { Faker::Name.name }
      done false
      todo_id nil
    end
  end