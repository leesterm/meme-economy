class Meme < ActiveRecord::Base
  has_many :userholdings
  has_many :votes

  def buy(buy_amt, user)
    if buy_amt <= self.volume
      price = most_recent_price().price
      cost = price*buy_amt
      if user.balance >= cost
        %% TODO: Make user portfolio have unique entries for each meme option(what if they're different prices though when u buy 1st and 2nd time)%
        #user_holding = UserHolding.where(user_id: user.id, meme_id: self.id).first_or_create(amt: buy_amt, price: price)
        user_holding = UserHolding.create(user_id: user.id, meme_id: self.id,amt: buy_amt, buy_price: price)
        self.volume -= buy_amt
        user.balance -= cost
        self.save
        user.save
        return true
      end
    end

    return false
  end

  def sell(sell_amt, user)
    user_meme_volume = UserHolding.where(user_id: user.id, meme_id:self.id).sum("amt");# Should really only be 1 entry anyways
    puts "asdfasdfasDF:"+user_meme_volume.to_s
    #if sell_amt <

    total = sell_amt*most_recent_price().price

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

  def most_recent_price
    return MemePrice.where(meme_id: self.id).last()
  end

  def price_difference(p)
    return (most_recent_price().price-p)/p
  end

end
