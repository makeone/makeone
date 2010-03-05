class CreateElectronics < ActiveRecord::Migration
  def self.up
    create_table :electronics do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :electronics
  end
end
