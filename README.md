# テーブル設計

## users テーブル

| Column             | Type   | Options                        |
| ------------------ | ------ | ------------------------------ |
| nickname           | string | null: false                    |
| email              | string | null: false, unique: true       |
| encrypted_password | string | null: false                    |
| surname_kanji      | string | null: false                    |
| name_kanji         | string | null: false                    |
| surname_katakana   | string | null: false                    |
| name_katakana      | string | null: false                    |
| birthday           | data   | null: false                    |

### Association

- has_many :items
- has_many :buys

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| goods_explain      | text       | null: false                    |
| user               | references | null: false, foreign_key: true |
| category_id        | integer    | null: false                    |
| goods_condition_id | integer    | null: false                    |
| shipping_fee_id    | integer    | null: false                    |
| prefectures_id     | integer    | null: false                    |
| delivery_time_id   | integer    | null: false                    |
| price              | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :buy
- belongs_to_active_hash :category 
- belongs_to_active_hash :goods_condition
- belongs_to_active_hash :shipping_fee
- belongs_to_active_hash :prefectures
- belongs_to_active_hash :delivery_time

## buys テーブル

| Column    | Type    | Options                        |
| --------- | ------- | ------------------------------ |
| user_id   | integer | null: false, foreign_key: true |
| item_id   | integer | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :residence

## residences テーブル

| Column           | Type    | Options     |
| ---------------- | ------- | ----------- |
| zip_code         | string  | null: false |
| prefectures_id   | integer | null: false |
| municipality     | string  | null: false |
| street_number    | string  | null: false |
| building_name    | string  |             |
| telephone_number | integer | null: false |

### Association

- belongs_to :buy
- has_one_active_hash :prefectures

