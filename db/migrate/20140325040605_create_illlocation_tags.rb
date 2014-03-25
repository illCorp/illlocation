class CreateIlllocationTags < ActiveRecord::Migration
  def change
    create_table :illlocation_tags do |t|
      t.references :location, index: true
      t.string :name

      t.timestamps
    end
  end
end
