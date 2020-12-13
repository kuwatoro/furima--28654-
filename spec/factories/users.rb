FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    surname_kanji         {"花京院"}
    name_kanji            {"典明"}
    surname_katakana      {"カキョウイン"}
    name_katakana         {"ノリアキ"}
    birthday              {"1999.01.13"}
  end
end
