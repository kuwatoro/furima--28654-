# テーブル設計

## users テーブル

| Column             | Type     | Options                        |
| ------------------ | -------- | ------------------------------ |
| nickname           | string   | null: false                    |
| email              | string   | null: false, uniqe: true       |
| encrypted_password | string   | null: false                    |
| surname_kanji      | string   | null: false                    |
| name_kanji         | string   | null: false                    |
| surname_katakana   | string   | null: false                    |
| name_katakana      | string   | null: false                    |
| birthday           | datetime | null: false                    |

### Association

- has_many :items
- has_many :buys

## items テーブル

| Column          | Type    | Options                        |
| --------------- | ------- | ------------------------------ |
| goods           | string  | null: false                    |
| goods_explain   | text    | null: false                    |
| user            | integer | null: false, foreign_key: true |
| category        | integer | null: false                    |
| goods_condition | integer | null: false                    |
| shipping_fee    | integer | null: false                    |
| prefectures     | integer | null: false                    |
| delivery_time   | integer | null: false                    |
| price           | integer | null: false                    |

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
| user      | integer | null: false, foreign_key: true |
| item      | integer | null: false, foreign_key: true |
| residence | integer | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :residence

## residences テーブル

| Column           | Type    | Options     |
| ---------------- | ------- | ----------- |
| card_number      | integer | null: false |
| expiration_date  | integer | null: false |
| security_code    | integer | null: false |
| zip_code         | integer | null: false |
| prefectures      | integer | null: false |
| municipality     | string  | null: false |
| street_number    | string  | null: false |
| building_name    | string  |             |
| telephone_number | integer | null: false |

### Association

- has_one :buy
- has_one_active_hash :prefectures

