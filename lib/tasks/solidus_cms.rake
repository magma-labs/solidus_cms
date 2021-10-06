# frozen_string_literal: true

namespace :solidus_cms do
  task sync_components: :environment do
    components = []
    Dir[Rails.root.join('app/presenters/cms/*.rb')].each do |file|
      component_name = file.split('/').last.gsub('_presenter.rb', '')
      next if component_name.eql?('components_base')

      puts "Syncing #{component_name}"
      presenter = "Cms::#{component_name.camelize}Presenter".constantize
      Cms::Component.find_or_create_by(name: component_name,
                                       component_type: presenter.component_type)
      components << component_name
    end
    Cms::Component.where.not(name: components).destroy_all
  end
end
