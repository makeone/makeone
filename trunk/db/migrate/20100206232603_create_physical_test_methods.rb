class CreatePhysicalTestMethods < ActiveRecord::Migration
  def self.up
    create_table :physical_test_methods do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :physical_test_methods
  end
end
