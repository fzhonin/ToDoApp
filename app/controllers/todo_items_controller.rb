class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, except: [:create]

  def create
    @todo_item = @todo_list.todo_items.create(todo_item_params)
    redirect_to @todo_list
  end

  def destroy
    if @todo_item.destroy
      flash[:success] = "Todo List item was deleted."
    else
      flash[:error] = "Todo List item could not be deleted."
    end
    redirect_to @todo_list
  end

  def complete
    if @todo_item.completed_at.nil?
    @todo_item.update_attribute(:completed_at, Time.now)
    redirect_to @todo_list, notice: "Todo item completed"
    else
      @todo_item.update_attribute(:completed_at, nil)
      redirect_to @todo_list, notice: "Todo item set as uncompleted"
    end
    end

  def important
    temp = !@todo_item.is_important
    @todo_item.update_attribute(:is_important, temp)
    if temp
    redirect_to @todo_list, notice: "Todo item set as important"
    else
      redirect_to @todo_list, notice: "Todo item set as unimportant"
    end
  end

  private



  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def todo_item_params
    params[:todo_item].permit(:content)
  end

end