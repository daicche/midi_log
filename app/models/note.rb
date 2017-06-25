class Note < ActiveRecord::Base
  def self.count_of_today
    Note.where(event: 144, created_at: Time.now.all_day).where.not(velocity: 0).count
  end
end
