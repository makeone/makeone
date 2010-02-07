class CreatePostProcessingTechniques < ActiveRecord::Migration
  def self.up
    create_table :post_processing_techniques do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :post_processing_techniques
  end
end
