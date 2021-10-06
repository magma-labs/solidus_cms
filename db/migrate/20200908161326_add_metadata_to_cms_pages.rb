class AddMetadataToCmsPages < ActiveRecord::Migration[6.0]
  def change
    add_column :cms_pages, :metadata, :jsonb
  end
end
