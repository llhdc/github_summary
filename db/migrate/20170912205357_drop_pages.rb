class DropPages < ActiveRecord::Migration[5.1]
  def change
    drop_table :pages
  end
end
