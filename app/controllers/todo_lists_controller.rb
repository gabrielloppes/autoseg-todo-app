class TodoListsController < ApplicationController
  before_action :locate_favorites, only: [:show, :locate]
  before_action :set_todo_list, only: [:update, :destroy]
  before_action :set_todo_list_id, only: [:create_todo_item, :make_it_public, :make_it_private]
  
  def index
    # Mostra as listas criadas na order decrescente
    @todo_lists = current_user.todo_lists.order(created_at: :desc)
  end
  
  def show
    if !check_access?
      flash[:alert] = "You don't have access to this list"
      redirect_to root_path
    else
      return @todo_list, @favorites_ids
    end
  end
  
  # No momento da criação de uma lista, o usuário pode criar divernos itens(tarefas) para essa lista
  def new
    @todo_list = TodoList.new
    @todo_list.todo_items.build
  end
  
  
  def create
    @todo_list = TodoList.new(todo_list_params)
    @todo_list.user = current_user
    if @todo_list.save
      flash[:notice] = 'To-do list was created'
      redirect_to todo_lists_path
    else
      render :new
    end
  end

  # Verifica o acesso do usuário antes de editar uma lista
  def edit
    if !check_access?
      flash[:notice] = "You don't have access to this list"
      redirect_to root_path
    end
  end
  
  def update
    if @todo_list.update(todo_list_params)
      redirect_to todo_lists_path
    else
      render :edit
    end
  end

  # Método para tornar uma determinada lista privada
  def make_it_private
    @todo_list.update(status: :personal)
    flash[:notice] = "'#{@todo_list.name}' is now private"
    redirect_to todo_list_path(@todo_list)
  end

  # Método para tornar uma determinada lista publica
  def make_it_public
    @todo_list.update(status: :shareable)
    flash[:notice] = "'#{@todo_list.name}' is now public"
    redirect_to todo_list_path(@todo_list)
  end
  
  def destroy
    if @todo_list.destroy
      redirect_to todo_lists_url
    end
  end

  # Cria tarefas
  def create_todo_item
    @todo_list.update(todo_list_params)
    redirect_to @todo_list
  end

  def locate
    @todo_lists = TodoList.where(status: :shareable).where.not(user_id: current_user.id).order(created_at: :desc)
  end
  
  private

  # Verifica se o usuário tem direito de acesso à lista
  def check_access
    @todo_list = TodoList.find(params[:id])
    # Verifica se o usuário é o dono da lista(terá acesso pois é o criador) ou verifica se a lista é pública, desta maneira qualquer usuário terá acesso
    (@todo_list.user == current_user || @todo_list.shareable?) ? true : false
  end

  def locate_favorites
    # Passa um bloco como argumento e usa dentro dentro do método
    @favorites = current_user.favorites.map(&:todo_list)
    @favorites_ids = []
    @favorites.each { |item| @favorites_ids << item.id }
    return @favorites_ids
  end

  def set_todo_list
    @todo_list = TodoList.find(params[:id])
  end
  
  # Permite apenas parametros confiaveis passar
  def todo_list_params
    params.require(:todo_list).permit(:name, task_items_attributes: [:id, :description])
  end

  def set_todo_list_id 
    @todo_list = TodoList.find(params[:todo_list_id])
  end
end