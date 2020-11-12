class TasksController < ApplicationController
  def set_it_done
    @todo_item = TodoItem.find(params[:todo_item_id])
    @todo_item.update(status: :closed)
    flash[:notice] = "'#{todo_item.description}' marked as done"
    redirect_to todo_list_path(@todo_item.todo_list)
  end

  def set_it_undone
    @todo_item = TodoItem.find(params[:todo_item_id])
    @todo_item.update(status: :open)
    flash[:notice] = "'#{todo_item.description}' marked as undone"
    redirect_to todo_list_path(@todo_item.todo_list)
  end

  def destroy
    @todo_item = TodoItem.find(params[:id])
    @todo_item.destroy
    redirect_to edit_todo_list_path(params[:todo_list_id])
  end
end
