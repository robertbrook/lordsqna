class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :member
      t.string :text
      t.string :uin
      t.integer :answer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
