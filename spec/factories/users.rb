FactoryBot.define do
  factory :user do
    name {"Joe"}
    email {"joe214@gmail.com"}
    password {"123456"}
    password_digest {"123456"}
    admin {false}
  end

  factory :admin do
    name {"Administrator"}
    email {"admin@gmail.com"}
    password {"123456"}
    password_digest {"123456"}
    admin {true}
  end
end
