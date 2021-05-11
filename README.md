# テーブル設計


## users テーブル
|     Column        |    Type   |           Options           |
| ----------------- | --------- | --------------------------- |
| nickname          | string    | null: false                 |
| email             | string    | null: false, unique: true   |
| encrypted_password| string    | null: false                 |
| last_name         | string    | null: false                 |
| fist_name         | string    | null: false                 |
| last_name_kana    | string    | null: false                 |
| first_name_kana   | string    | null: false                 |
| birth_day         | date      | null: false                 |
 
### Association
- has_many :buyers
- has_many :items

## items テーブル

|    Column      |    Type     |      Options       |
| -------------- | ----------- | ------------------ |
| name           | string      | null: false        |
| description    | text        | null: false        |  
| category_id    | integer     | null: false        |
| condition_id   | integer     | null: false        |
| burden_id      | integer     | null: false        |
| area_id        | integer     | null: false        |
| day_id         | integer     | null: false        |
| price          | integer     | null: false        |
| user           | references  | foreign_key: true  |

### Association
- has_one :buyers
- belongs_to :user


## buyers テーブル
|    Column      |    Type     |      Options       |
| -------------- | ----------  | ------------------ |
| user           | references  | foreign_key: true  |
| item           | references  | foreign_key: true  |

user（references型）（購入者）
item（references型）（商品）

### Association

- has_one :deliveries
- belongs_to :item
- belongs_to :user




## deliveries テーブル
|    Column      |    Type     |      Options       |
| -------------- | ----------- | ------------------ |
| post_code      | string      | null: false        |
| prefecture     | integer     | null: false        |
| city           | string      | null: false        |
| address        | string      | null: false        |    
| building_name  | string      |                    |
| phone_number   | string      | null: false        |
| purchase       | references  | foreign_key: true  |

### Association
belongs_to :buyers

