class TodoList < ApplicationRecord
  belongs_to :user
  has_many :todo_items, dependent: :destroy
  accepts_nested_attributes_for :todo_items, allow_destroy: true, reject_if: proc { |attributes| attributes['description'].blank? }
  enum status: { personal: 0, shareable: 5 }
  validates :name, presence: { message: "Name can't be blank" }
end