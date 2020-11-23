# テーブル設計

## users テーブル

| Column           | Type    | Options                        |
| ---------------- | ------- | ------------------------------ |
| nickname         | string  | null: false                    |
| email            | string  | null: false, uniqe: true       |
| password         | string  | null: false                    |
| password_check   | string  | null: false                    |
| surname_kanji    | string  | null: false                    |
| name_kanji       | string  | null: false                    |
| surname_katakana | string  | null: false                    |
| name_katakana    | string  | null: false                    |
| year_id          | integer | null: false                    |
| month_id         | integer | null: false                    |
| day_id           | integer | null: false                    |

### Association

- has_many :item
- has_many :buy

## items テーブル

| Column             | Type    | Options                        |
| ------------------ | ------- | ------------------------------ |
| goods              | string  | null: false                    |
| goods_explain      | text    | null: false                    |
| seller_id          | integer | null: false, foreign_key: true |
| category_id        | integer | null: false                    |
| goods_condition_id | integer | null: false                    |
| price              | integer | null: false                    |

### Association

- belongs_to :user
- has_one :buy

## buys テーブル

| Column        | Type     | Options     |
| ------------- | -------- | ----------- |
| buyer         | string   | null: false |
| purchase      | string   | null: false |
| purchase_date | datetime | null: false |

### Association

- belongs_to :user
- belongs_to :item
- has_one :residence

## residences テーブル

| Column           | Type    | Options     |
| ---------------- | ------- | ----------- |
| shipping_fee_id  | integer | null: false |
| prefecture_id    | integer | null: false |
| delivery_time_id | integer | null: false |

### Association

- belongs_to :buy
