FactoryBot.define do
    factory :user do
      id {1}
      sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@sample.com" }
      password { "123456" }

    end
    factory :chat do
      id {1}
    end
    factory :tag do
      name {"placeholder"}
    end
    factory :community do
      name {"placeholder"}
    end
end