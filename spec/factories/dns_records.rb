FactoryBot.define do
  factory :dns_record do
    sequence(:ip_address) { |n| "1.1.1.#{n}" }
  end
end
