
## データの登録
* 登録する前にオブジェクト作る

``` ruby
>> user = User.new(name: "Michael Hartl", email: "michael@example.com")
>> user
=> #<User:0x000071de8e40aab8 id: nil, name: "Michael Hartl", email: "michael@example.com", created_at: nil, updated_at: nil>
>> user.save # 登録
```
  * オブジェクト作らずに登録する
``` ruby
>> User.create(name: "Michael Hartl", email: "michael@example.com")
```
## データの更新
* オブジェクトを作って更新する
``` ruby
>> user.email="hoge@email.com"
>> user.save
```
* オブジェクトの取り消し
``` ruby
>> user.email="hoge@email.com"
>> user.reload.email
```
* オブジェクトを作らずに更新する
``` ruby
>> user.update(name: "The Dude", email: "dude@abides.org")
=> true
または
>> user.update_attribute(:name, "El Duderino")
=> true
```
|メソッド|バリデーション|複数カラム更新|updated_at 更新|保存|
|--|--|--|--|--|
|user.update(...)|✅ あり|✅ 複数OK|✅ 更新される|✅ される|
|user.update_attribute(:key, val)|✅ あり（ただし緩め）|❌ 単一のみ|✅ 更新される|✅ される|

## データの参照
### DBに登録されてる一部データの参照
* idから取得
``` ruby 
>> User.find(1) # 1はidの番号
```
* 一致する中から最初の1件飲み取得
``` ruby
>> User.find_by(email: "michael@example.com")
```
* User.allの最初のユーザ
``` ruby
>> User.first
```
* where
``` ruby
>> User.where(name: "Alice")
```
### DBに登録されてる全てのデータの参照
``` ruby
>> User.all
```
* まだ登録されてないオブジェクトを見る
``` ruby
>> user1 = User.new(name: "A", email: "a@example.com")
>> user2 = User.create(name: "B", email: "b@example.com")

>> User.all.count        
=> 1  #（user2だけ保存済み）
>> user1.persisted?
=> false  # (保存されてない）
>> user2.persisted?     
=> true #（保存されている）
```

  * 複数オブジェクトを後で参照する

``` ruby
>> unsaved_users = []
>> unsaved_users << User.new(name: "Alice")
>> unsaved_users << User.new(name: "Bob")

>> unsaved_users.each do |u|
     puts "#{u.name} saved? => #{u.persisted?}"
   end
```

> **❓User.new()で変数に入れ忘れた場合は参照できないのか**
> <br/>**A:** 参照できないが、saveすればDBに登録される
> <br/> 直前のものであれば`_`で参照できる
> ``` ruby
> >> User.new(name: "Foo")
> => #<User id: nil, name: "Foo", ...>
> >> _.persisted?   # => false
> >> _.save
> ```

---
## その他
### テーブル定義見る
* show_table(Table)で見れるように設定した

``` ruby
>> User.columns.each do |col|
  is_primary = (User.primary_key == col.name)
  puts [
    "name=#{col.name.ljust(12)}",
    "type=#{col.sql_type.ljust(15)}",
    "null=#{col.null ? 'OK' : 'NOT NULL'}",
    "primary=#{is_primary}"
  ].join(" | ")
end; nil
```


### Gemfile
* package.jsonのようなもの
``` bash
$ bundle install
```