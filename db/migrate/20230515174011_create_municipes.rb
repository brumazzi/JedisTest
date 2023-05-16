class CreateMunicipes < ActiveRecord::Migration[7.0]
  def change
    create_table :municipes do |t|
      t.string :name
      t.string :cpf
      t.string :cns
      t.string :email
      t.date :birth
      t.string :phone
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
