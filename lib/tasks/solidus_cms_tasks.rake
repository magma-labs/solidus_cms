namespace :solidus_cms do
  task sync_components: :environment do
    components = []
    path = File.join(File.dirname(__FILE__), '..', '..', 'app', 'presenters', 'solidus_cms', '*.rb')
    Dir[path].each do |file|
      component_name = file.split('/').last.gsub('_presenter.rb', '')
      next if component_name.eql?('components_base')

      puts "Syncing #{component_name}"
      presenter = "SolidusCms::#{component_name.camelize}Presenter".constantize
      SolidusCms::Component.find_or_create_by(name: component_name,
                                       component_type: presenter.component_type)
      components << component_name
    end
    SolidusCms::Component.where.not(name: components).destroy_all
  end

  task fill_positions: :environment do
    SolidusCms::Page.find_each do |page|
      page.components_pages.top_level.each_with_index do |component, index|
        component.update(position: index + 1) unless component.position
        component.children.each_with_index do |sub_component, sub_index|
          sub_component.update(position: sub_index + 1) unless sub_component.position
        end
      end
    end
  end

  task migrate_static_pages: :environment do
    I18n.t('static_pages').each do |static_page|
      static = Spree::Page.find_by(slug: static_page[:slug])
      title = static&.title || static_page[:title]
      body = static&.body || static_page[:body_html]
      page = SolidusCms::Page.where(path: static_page[:slug]).first_or_create!(
        name: title,
        active: true
      )

      column = SolidusCms::Component.find_by(name: 'columns')
      parent = page.components_pages.where(name: title).first_or_create!(
        component: column
      )
      parent.update(
        metadata: {
            section_title: title
        }
      )

      component = SolidusCms::Component.find_by(name: 'rich_text')
      child = parent.children.where(name: title).first_or_create!(
        page: page,
        component: component
      )

      child.update(
        metadata: {
            body: body
        }
      )

      static&.destroy
    end
  end
end
