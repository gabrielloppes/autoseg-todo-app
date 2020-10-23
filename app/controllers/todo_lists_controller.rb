class TodoListsController < ApplicationController
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]
  
  def index
    @todo_lists = TodoList.all
  end
  
  def show
  end
  
  def new
    @todo_list = TodoList.new
  end
  
  def edit
  end
  
  def create
    @todo_list = TodoList.new(todo_list_params)
    if @todo_list.save
      flash[:notice] = 'TO-DO List was successfully created'
      redirect_to todo_lists_path
    else
      render [:new, status: :ok, location: @todo_list]
    end
  end
  
  def update
    if @todo_list.update(todo_list_params)
      flash[:notice] = "TO-DO list was successfully updated"
      redirect_to todo_lists_path
    else
      render :edit
    end
  end
  
  def destroy
    @todo_list.destroy
      flash[:notice] =  'Todo list was successfully destroyed.'
      redirect_to todo_lists_url
  end
  
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def todo_list_params
    params.require(:todo_list).permit(:title, :description)
  end
end
