class CreateDigitalTestMethods < ActiveRecord::Migration
  def self.up
    create_table :digital_test_methods do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :digital_test_methods
  end
end
