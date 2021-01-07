FactoryBot.define do
  factory :order_residence do
    zip_code         {"123-4567"}
    prefecture_id    {2}
    municipality     {"横浜市緑区"}
    street_number    {"青山1−1−1"}
    building_name    {"柳ビル103"}
    telephone_number {"09012345678"}
    token            {"tok_abcdefghijk00000000000000000"}
  end
end
