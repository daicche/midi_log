class Note < ActiveRecord::Base
  scope :keystrokes, -> {
    where.not(event: 176).
    where.not(velocity: 0)
  }

  def self.count_of_today
    Note.where(event: 144, created_at: Time.now.all_day)
        .where.not(velocity: 0)
        .count
  end
end
