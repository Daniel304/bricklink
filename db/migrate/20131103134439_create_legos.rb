class CreateLegos < ActiveRecord::Migration
  def change
    create_table :legos do |t|

      t.timestamps
    end
  end
end
