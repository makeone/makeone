class CreateOperatingParameters < ActiveRecord::Migration
  def self.up
    create_table :operating_parameters do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :operating_parameters
  end
end
