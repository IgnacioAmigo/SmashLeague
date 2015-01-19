class Match < ActiveRecord::Base
  belongs_to :challenger, :foreign_key => :challenger_id, class_name: 'User'
  belongs_to :challenged, :foreign_key => :challenged_id, class_name: 'User'
  validates :challenger_id, presence: true
  validates :challenged_id, presence: true


  def editable_by(user)
	return ((user.admin) or (!accepted and challenger.id == user.id))	
  end

  def try_to_determine_winner
  	challenger_won = nil
  	challenger_won = true if challenger_posted_challenger_won and challenged_posted_challenger_won
  	challenger_won = false if !challenger_posted_challenger_won and !challenged_posted_challenger_won
  end

end
	