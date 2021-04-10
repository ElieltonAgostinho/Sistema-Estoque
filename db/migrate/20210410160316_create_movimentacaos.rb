class CreateMovimentacaos < ActiveRecord::Migration[6.1]
  def change
    create_table :movimentacaos do |t|
      t.references :produtos, foreign_key: true
      t.references :local_armazenamentos, foreign_key: true
      t.string :tipo
      t.datetime :data
      t.integer :quantidade
      t.timestamps
    end
  end
end
