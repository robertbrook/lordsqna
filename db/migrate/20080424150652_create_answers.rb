class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.string :member
      t.integer :answer_group_id
      t.string :role
      t.string :text

      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
