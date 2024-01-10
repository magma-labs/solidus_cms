class AddSolidusCmsTables < ActiveRecord::Migration[5.2]
  def change
    create_table :solidus_cms_pages, if_not_exists: true do |t|
      t.string :name
      t.string :path, index: { unique: true }
      t.json :metadata
      t.timestamp :discarded_at
      t.boolean :active, default: false
      t.timestamps
    end

    create_table :solidus_cms_components, if_not_exists: true do |t|
      t.string :name
      t.string :component_type
      t.timestamps
    end

    create_table :solidus_cms_components_pages, if_not_exists: true do |t|
      t.references :page
      t.references :component
      t.references :parent
      t.string :name
      t.integer :position
      t.json :metadata
    end
  end
end
