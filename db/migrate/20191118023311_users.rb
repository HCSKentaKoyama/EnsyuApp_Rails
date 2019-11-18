class Users < ActiveRecord::Migration[5.2]
  def change
    create_table :users,id: :string,primary_key: :user_id do |t|
      # :user_idが主キー :string型
      t.string :password_digest,null: false
      t.string :name,null: false
      t.string :class_number,:limit => 6
      t.string :mail
      t.string :teacher_id
      t.string :role,null: false
      t.timestamps
    end
  end
end
