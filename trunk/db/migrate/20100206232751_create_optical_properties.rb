class CreateOpticalProperties < ActiveRecord::Migration
  def self.up
    create_table :optical_properties do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :optical_properties
  end
end
