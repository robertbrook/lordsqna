class CreateAnswerGroups < ActiveRecord::Migration
  def self.up
    create_table :answer_groups do |t|
      t.string :anchor
      t.date :date
      t.integer :minor_subject_id
      t.integer :subject_id
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :answer_groups
  end
end
