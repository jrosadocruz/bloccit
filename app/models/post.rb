class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  default_scope { order('rank DESC') }
  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24)
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end


  scope :for_user, -> (user)  { where(user_id: user.id)  }
  scope :by_email, -> (email) { joins(:user).where(:users => {email: email})}

  validates :title , length: { minimum: 5 }  , presence: true
  validates :body  , length: { minimum: 20 } , presence: true
  validates :topic , presence: true
  validates :user  , presence: true

  def create_vote
    user.votes.create({value: 1, post:self})
  end

end
