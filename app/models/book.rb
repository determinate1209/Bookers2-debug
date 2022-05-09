class Book < ApplicationRecord
  
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_two_days_ago, -> { where(created_at: 2.days.ago.all_day) }
  scope :created_three_days_ago, -> { where(created_at: 3.days.ago.all_day) }
  scope :created_four_days_ago, -> { where(created_at: 4.days.ago.all_day) }
  scope :created_five_days_ago, -> { where(created_at: 5.days.ago.all_day) }
  scope :created_six_days_ago, -> { where(created_at: 6.days.ago.all_day) }
  
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  
  
end
