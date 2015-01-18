class AddChallengerPostedChallengerWonAndChallengedPostedChallengerWonToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :challenger_posted_challenger_won, :boolean
    add_column :matches, :challenged_posted_challenger_won, :boolean
  end
end
