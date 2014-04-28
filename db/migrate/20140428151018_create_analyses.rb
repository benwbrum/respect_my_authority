class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.string :data_provider
      t.string :subject
      t.string :q
      t.string :status, :default => 'pending'
      t.integer :result_count, :default => 0

      t.timestamps
    end
  end
end
