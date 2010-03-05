class CreateAmTechnologies < ActiveRecord::Migration
  def self.up
    create_table :am_technologies do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :am_technologies
  end
end
