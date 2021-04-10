class CreateLocalArmazenamentos < ActiveRecord::Migration[6.1]
  def change
    create_table :local_armazenamentos do |t|
      t.string :nome

      t.timestamps
    end
  end
end
