class AddActiveToCustomPagesComponents < ActiveRecord::Migration[6.0]
  def change
    add_column :cms_components_pages, :active, :boolean, default: true
  end
end
