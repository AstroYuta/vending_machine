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

##Todo
- #add_productのspec追加
 - 2本同じproductが追加されたときは統合するように仕様変更 => DONE
- #buyのspec追加
 - 2本productが存在する場合に、任意のものを選んで買う場合 => DONE
- #reset_productを追加
 - #reset_productと#remove_productかな
- リファクタリング

#個数に関するspecについて
##実装したいこと
- VendingMachineの#add_having_productで、任意の種類のproductが一気に渡せる
 - イメージ:
 machine = VendingMachine.new
 machine.add_having_product(Product.new(hoge), Product.new(hogehoge), ....)ができる
 - 数が可変の引数をどう扱えばいいのだろう

- VendingMachineの@having_productにproductの数という概念を加えたい
 - having_productはhashで管理されている
 - ここにどのように数に関するフラグを立てれば良いのか...
 - product側で何本かを示すインスタンス変数を用意しようかと思ったが、本来productは商品1本1本そのものであり、
 VendingMachineの中であるからこそ、数という概念が出てくる気がする=>のでVendingMachine側で実装すべきでは
 - どうしよう...

 ##Todo SEPTEMBER 8th
 - #add_having_productで負のプロダクト数を渡した時、raise ArgumentErrorするかどうかのテスト追加 => すぐできそう
 - #remove_having_productで負のプロダクト数を渡した時、raise ArgumentErrorするかどうかのテスト追加 => すぐできそう
 - あるproductのすべての在庫を取り払うような、#remove_having_ALL_productという新しい関数を追加=> 優先順位は低い
 - そもそも、関数ごとに、実行した結果stockが負になる時raise ArgumentErrorするという仕様でなく、stockの値はいかなる時も０以上で、負になったらraise ArgumentErrorするような仕様にしたい => どうしよう...
 - リファクタリング => 膨大になってきて、頭がこんがらがってきた
