class TodoItem < ApplicationRecord
  belongs_to :todo_list
  # Only creates a todo-item if the description exists
  validates :description, presence: { message: "Description can't be blank" }

  enum status: { open: 0, closed: 5 }
end