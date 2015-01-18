class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  has_many :conversations, :foreign_key => :sender_id
  has_many :news

  has_many :matches_created, :class_name => 'Match', :foreign_key => :challenger_id
  has_many :matches_received, :class_name => "Match", :foreign_key => :challenged_id

  def matches_total
  	return Match.where('challenger_id =? or challenged_id = ?',id,id)
  end

  def matches_pending
    return matches_received.where('accepted = false or accepted is null')
  end
end
