class TodoItem < ApplicationRecord
  belongs_to :todo_list
  # Only creates a todo-item if the content exists
  validates :content, presence: true
end