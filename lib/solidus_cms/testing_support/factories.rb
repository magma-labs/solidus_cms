# frozen_string_literal: true

FactoryBot.define do
  factory :page, class: "Cms::Page" do
    name { "Testing page" }
    path { "/testing-path" }

    after :create do |page|
      Cms::Component.containers.each do |component|
        page.components_pages.create!(component: component, name: "Test #{component.name}")
      end
      Cms::Component.content.each_with_index do |component, index|
        page.components_pages.top_level[index % 2].children.create!(component: component, name: "Test #{component.name}", page: page)
      end
    end
  end
end
