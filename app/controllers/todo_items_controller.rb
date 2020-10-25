class TodoItemsController < ApplicationController
  before_action :set_todo_list
  # I can create a to-do item inside a list with a set of trusted paramters
  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    redirect_to @todo_list
  end

  # I can delete a specific to-do item, if all items be deleted the whole list will also be destroyed
  def destroy 
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
      flash[:success] = "Todo item was destroyed"
    else
      flash[:error] = "Todo item could not be deleted"
    end
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
