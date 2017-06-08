class Meme < ActiveRecord::Base
  has_many :userholdings
  has_many :votes

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
end
