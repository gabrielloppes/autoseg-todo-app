class TodoListsController < ApplicationController
  before_action :authenticate_user!
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
      flash[:notice] = 'To-do List was successfully created'
      redirect_to todo_lists_path
    else
      render :new
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
    if @todo_list.destroy
      flash[:notice] =  'Todo list was successfully destroyed.'
      redirect_to todo_lists_url
    end
  end
  
  private

  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end
  
  # Trusted params
  def todo_list_params
    params.require(:todo_list).permit(:title, :description, :created_at)
  end
end