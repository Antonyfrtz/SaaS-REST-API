FactoryBot.define do
  factory :post do
    title {'test post for testing'}
    content {'test content wow such nice tests'}
    user
    category
  end
end
