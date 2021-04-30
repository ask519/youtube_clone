FactoryBot.define do
  factory :comment do
    id {1}
    user_id {1}
    reference {1}
    body {"Test Comment"}
  end
end