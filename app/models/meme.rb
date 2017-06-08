class Meme < ActiveRecord::Base
  has_many :userholdings

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
