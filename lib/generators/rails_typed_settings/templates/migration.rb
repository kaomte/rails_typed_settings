class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :var_name, null: false
      t.string :var_type, null: false
      t.text :description
      t.text :transformed_value
      t.text :default_transformed_value
      t.timestamps null: false
    end

    add_index :settings, %i(var_name), unique: true
  end
end
