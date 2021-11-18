class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.string :full_name
      t.string :social_name
      t.date :birth_date
      t.string :cpf
      t.string :zipcode
      t.string :address_line_one
      t.string :address_line_two
      t.string :city
      t.string :state
      t.string :country
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :user_profiles, :cpf, unique: true
  end
end
