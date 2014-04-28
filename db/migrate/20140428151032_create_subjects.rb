class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name, index: true
      t.integer :items, default: 0
      t.boolean :has_loc_sh
      t.boolean :loc_sh_alias
      t.string :loc_sh_url
      t.references :analysis, index: true

      t.timestamps
    end
  end
end
