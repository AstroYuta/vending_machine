# ここに設計を書いて行く

## オブジェクト
- 自動販売機 => Machine class
- お財布 => Wallet class
- 商品 => Product class

## 設計
- まずWallet class からお金を取り出し投入する
- Product classから商品を選ぶ
- Machine class で購入する動作を実装する
 - 投入されたお金と、購入したProductの差分をお釣りとして渡す
- 最後にお財布からProductの購入に要した費用を引く