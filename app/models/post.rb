class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic

  default_scope { order('created_at DESC') }

  scope :for_user, -> (user)  { where(user_id: user.id)  }
  scope :by_email, -> (email) { joins(:user).where(:users => {email: email})}

  # def self.for_user user
  #   where(user_id: user.id)
  # end

end
