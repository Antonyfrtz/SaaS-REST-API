FactoryBot.define do
  factory :post do
    title {'test post'}
    content {'test content'}
    user
    category
  end
end
