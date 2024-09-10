class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :chatroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end
