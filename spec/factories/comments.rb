FactoryBot.define do
  factory :comment do
    article { nil }
    user { nil }
    body { "MyString" }
  end
end
