class CreateCmsTables < ActiveRecord::Migration[6.0]
  def change
    create_table :cms_pages do |t|
      t.string :name
      t.string :path, index: { unique: true }

      t.boolean :active, default: false

      t.timestamps
    end
    create_table :cms_components do |t|
      t.string :name
      t.string :component_type

      t.timestamps
    end

    create_table :cms_components_pages do |t|
      t.references :page
      t.references :component
      t.references :parent

      t.string :name
      t.integer :position

      t.json :metadata
    end
  end
end
