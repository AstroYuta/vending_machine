# ここに設計を書いて行く

##　オブジェクト
- Machine(Entity)
 - お金をもらう
 - 商品を持つ
 - 商品を渡す
 - お釣りを返す

- Wallet(Entity)
 - お金を管理する
 - お金を入れる
 - お金を出す
 - 現在の金額を確認する
 - 識別子を考えないといけない（未来的には）

 - 渡されるインスタンスとしてはMoney.new(1500)とか
  - お金をいれられるとお金同士をたすということを行う
   - 足すと何が起きるかはMoneyに任せる
 - 今回は一旦貨幣単位を持たず、電子マネーのように合計に注目する  

- Money(Value Object)
 - 金額の情報を持つ
 - 単位に関する情報をもつ(5, 10, 50, 100, 500yen)

- Product(Value Object)
 - 商品に関する情報をもつ
  - 金額
  - なまえ
  - 容量
  - 色

