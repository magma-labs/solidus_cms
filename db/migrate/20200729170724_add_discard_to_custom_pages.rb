# frozen_string_literal: true

class AddDiscardToCustomPages < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    # rubocop:disable Layout/LineLength
    extra_args = ActiveRecord::Base.connection.instance_values["config"][:adapter] == "postgresql" ? { algorithm: :concurrently } : {}
    # rubocop:enable Layout/LineLength

    add_column :cms_pages, :discarded_at, :datetime
    add_column :cms_pages, :discarded_by, :bigint
    add_index :cms_pages, :discarded_at, **extra_args
  end
end
