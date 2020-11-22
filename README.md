# テーブル設計

## users テーブル

| Column    | Type   | Options                  |
| --------- | ------ | ------------------------ |
| name      | string | null: false              | 
| email     | string | null: false, uniqe: true |

### Association

- has_many :items
- has_many :buys

## items テーブル

| Column   | Type    | Options     |
| -------- | ------- | ----------- |
| item     | string  | null: false |
| category | string  | null: false |
| price    | integer | null: false |
| seller   | string  | null: false |

### Association

- belongs_to :users
- belongs_to :buys

## buys テーブル

| Column        | Type     | Options                        |
| ------------- | -------- | ------------------------------ |
| buyer         | string   | null: false                    |
| purchase      | string   | null: false, foreign_key: true |
| purchase_date | datetime | null: false                    |

### Association

- belongs_to :users
- has_one :items
- has_one :residences

## residences テーブル

| Column    | Type    | Options                        |
| --------- | ------- | ------------------------------ |
| residence | string  | null: false, foreign_key: true |

### Association

- belongs_to :buys
