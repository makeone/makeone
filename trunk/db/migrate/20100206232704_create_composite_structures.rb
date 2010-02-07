class CreateCompositeStructures < ActiveRecord::Migration
  def self.up
    create_table :composite_structures do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :composite_structures
  end
end
