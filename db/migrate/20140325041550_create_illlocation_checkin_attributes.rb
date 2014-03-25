class CreateIlllocationCheckinAttributes < ActiveRecord::Migration
  def change
    create_table :illlocation_checkin_attributes do |t|
      t.references :checkin, index: true
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
