class CreateEstoques < ActiveRecord::Migration[6.1]
  def change
    create_table :estoques do |t|
      t.references :produtos, foreign_key: true
      t.references :local_armazenamentos, foreign_key: true
      t.integer :quantidade
      t.timestamps
    end
  end
end
