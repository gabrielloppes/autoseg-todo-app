class TodoList < ApplicationRecord
  has_many :todo_items, dependent: :destroy
  has_many :user
end