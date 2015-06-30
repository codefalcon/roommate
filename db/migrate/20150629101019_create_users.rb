class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :company
      t.string :college
      t.integer :age

      t.timestamps
    end
  end
end
