FactoryBot.define do
  factory :item do
    name               {Faker::Commerce.name}
    goods_explain      {Faker::Lorem.sentence}
    category_id        {"2"}
    goods_condition_id {"2"}
    shipping_fee_id    {"2"}
    prefecture_id      {"2"}
    delivery_time_id   {"2"}
    price              {"32000"}
    association :user 

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/pokemon.png'), filename: 'pokemon.png')
    end
  end
end
