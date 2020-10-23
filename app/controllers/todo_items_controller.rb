class TodoItemsController < ApplicationController
  before_action :set_todo_list
  # I can create a to-do item inside a list with a set of trusted paramters
  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    redirect_to @todo_list
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end
end
