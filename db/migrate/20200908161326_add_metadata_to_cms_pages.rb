class AddMetadataToCmsPages < ActiveRecord::Migration[6.0]
  def change
    meta_type = ActiveRecord::Base.connection.instance_values["config"][:adapter] == "postgresql" ? :jsonb : :json
    add_column :cms_pages, :metadata, meta_type
  end
end
