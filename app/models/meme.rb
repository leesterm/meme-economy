class Meme < ActiveRecord::Base
  belongs_to :user
  has_many :portfolios
  has_many :transactionlogs
  has_many :votes

  # For Cloudinary
  attr_accessor :meme_img
  mount_uploader :meme_img, MemeImgUploader

  def buy(buy_amt, user)
    if buy_amt <= self.volume
      price = current_price().price
      cost = price*buy_amt
      if user.balance >= cost # Check if the user has enough money
        portfolio = Portfolio.find_by(user_id: user.id, meme_id: self.id)
        if portfolio # User already has a portfolio for this meme, update it
          portfolio.amt += buy_amt
          portfolio.total_cost += cost
          portfolio.save
        else # Create one since it doesn't exist
          portfolio = Portfolio.create(user_id: user.id, meme_id: self.id,amt: buy_amt, total_cost: cost)
        end
        transaction_log = TransactionLog.create(user_id: user.id, meme_id: self.id, amt: buy_amt, price: price, action: 'buy')
        self.volume -= buy_amt
        user.balance -= cost
        self.save
        user.save
        return true # Successful buy
      end
    end
    return false # Failed to buy
  end

  def sell(sell_amt, user)
    user_meme_volume = Portfolio.where(user_id: user.id, meme_id:self.id).sum("amt");# Should really only be 1 entry anyways
    puts "asdfasdfasDF:"+user_meme_volume.to_s
    #if sell_amt <
      #transaction_log = TransactionLog.create(user_id: user.id, meme_id: self.id, amt: buy_amt, price: price, action: 'sell')
    total = sell_amt*current_price().price

  end

  def upvote
    self.up += 1;
    self.save;
  end

  def downvote
    self.down += 1;
    self.save;
  end

  def score
    return self.up-self.down
  end

  def current_price
    return MemePrice.where(meme_id: self.id).last()
  end

  def previous_price
    return MemePrice.where(meme_id: self.id)[-2]
  end

  def price_difference(p)
    return (current_price().price-p)/p
  end

end
