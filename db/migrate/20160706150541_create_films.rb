class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.integer :budget
      t.timestamps null: false
    end
  end
end
