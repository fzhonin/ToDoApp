class AddIsImportantToTodoItems < ActiveRecord::Migration[6.0]
  def change
    add_column :todo_items, :is_important, :boolean
  end
end
