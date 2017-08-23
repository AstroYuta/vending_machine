# ここに設計を書いて行く

##　オブジェクト
- Machine(Entity)
 - お金をもらう
 - 商品を持つ
 - 商品を渡す
 - お釣りを返す

- Wallet(Entity)
 - お金を管理する

- Money(Value Object)
 - 金額の情報を持つ
 - 単位に関する情報をもつ(5, 10, 50, 100, 500yen)

- Product(Value Object)
 - 商品に関する情報をもつ
  - 金額
  - なまえ
  - 容量
  - 色

