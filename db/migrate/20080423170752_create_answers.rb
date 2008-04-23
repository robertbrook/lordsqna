class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.date :date
      t.string :major_subject
      t.string :member
      t.string :minor_subject
      t.string :role
      t.string :text
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
