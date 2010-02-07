class CreateCadCamSoftwares < ActiveRecord::Migration
  def self.up
    create_table :cad_cam_softwares do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :cad_cam_softwares
  end
end
