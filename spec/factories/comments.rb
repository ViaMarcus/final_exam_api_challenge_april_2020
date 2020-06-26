FactoryBot.define do
  factory :comment do
    association :article
    association :user
    body { "MyString" }
  end
end
