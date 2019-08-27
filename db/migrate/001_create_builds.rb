class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :status
      t.string :release
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :target
      t.string :builder
      t.integer :project_id
      t.string :commit
      t.text :logs
      t.timestamps
    end
  end
end
