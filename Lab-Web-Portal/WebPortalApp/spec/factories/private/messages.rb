FactoryBot.define do
  factory :private_message, class: 'Private::Message' do
    body {'hello there this is my message for you'}
    association :conversation, factory: :private_conversation
    user
  end
end
