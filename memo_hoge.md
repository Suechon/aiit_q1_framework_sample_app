## 前提条件
* db:migrateはして、反映させた状態
### コメントアウトしてる場合
* `user.rb`
``` ruby
class User < ApplicationRecord
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  # has_secure_password
end
```
* rails console
``` ruby
>> user = User.new(name: "Michael Hartl", email: "michael@example.com")
=> #<User:0x00007eec0e4ab658 id: nil, name: "Michael Hartl", email: "michael@example.com", created_at: nil, updated_at: nil, password_digest: nil>
>> user.valid?
=> true
```
バリデーション通る

### コメントアウトしてない場合
* `user.rb`
``` ruby
class User < ApplicationRecord
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password ←これ
end
```
* rails console
``` ruby
>> user = User.new(name: "Michael Hartl", email: "michael@example.com")
=> #<User:0x00007c9705215250 id: nil, name: "Michael Hartl", email: "michael@example.com", created_at: nil, updated_at: nil, password_digest: nil>
>> user.valid?
=> false
```
バリデーション通らない
