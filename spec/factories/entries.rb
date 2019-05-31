FactoryBot.define do
  factory :entry do
    title {"Joe's first entry"}
    body {"Joe's first entry body"}
  end

  factory :entry_with_comment do
    title {"Joe's first entry with comment"}
    body {"Joe's first entry body with comment"}
    user
    comment
  end
end
