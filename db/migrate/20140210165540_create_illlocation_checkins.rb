class CreateIlllocationCheckins < ActiveRecord::Migration
  def change
    create_table :illlocation_checkins do |t|
      t.references :location
      t.integer :locatable_id
      t.string :locatable_type
      t.timestamps
    end
    
    add_index :illlocation_checkins, [:locatable_id, :locatable_type]
  end
end
