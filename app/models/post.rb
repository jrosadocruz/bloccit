class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value)
  end

  default_scope { order('created_at DESC') }

  scope :for_user, -> (user)  { where(user_id: user.id)  }
  scope :by_email, -> (email) { joins(:user).where(:users => {email: email})}

  validates :title , length: { minimum: 5 }  , presence: true
  validates :body  , length: { minimum: 20 } , presence: true
  # validates :topic , presence: true
  # validates :user  , presence: true

  # def self.for_user user
  #   where(user_id: user.id)
  # end

end
