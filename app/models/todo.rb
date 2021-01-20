class Todo < ActiveRecord::Base
  def self.overdue
    all.where("due_date < ?", Date.today)
  end

  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def self.due_later
    all.where("due_date > ?", Date.today)
  end

  def self.completed
    all.where(completed: true)
  end

  def self.remaining
    all.where(completed: false)
  end

  def to_pleasant_string
    "#{id}. #{due_date.to_s} #{todo_text} #{completed ? "[X]" : "[ ]"}"
  end
end
