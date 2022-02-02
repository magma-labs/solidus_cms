# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Custom Pages', type: :feature, js: true, cms_component: true do
  let(:cms_page) { Cms::Page.create(name: 'random page', path: '/random/page', active: true) }
  let(:parent) do
    cms_page.components_pages.create(name: 'Container', component: container)
  end
  let(:sub_component) do
    parent.children.create(name: 'Sub component',
                           component: component,
                           page: cms_page)
  end

  context 'with columns container' do
    let(:container) { Cms::Component.containers.first }

    before do
      sub_component.metadata = { title: 'title content', content: 'content body' }
      sub_component.save
      visit '/random/page'
    end

    context 'with rich_text_component' do
      let(:component) { Cms::Component.find_by(name: 'rich_text') }

      it 'when visiting a random active page' do
        sub_component.metadata = { body: 'content body' }
        sub_component.save
        visit '/random/page'
        expect(page).to have_text 'body'
      end

      def override_home_page(cms_page)
        parent = cms_page.components_pages.create(name: 'Container',
                                                  component: container)
        sub_component = parent.children.create(name: 'Sub component',
                                               component: component,
                                               page: cms_page)
        sub_component.metadata = { body: 'homepage' }
        sub_component.save
      end

      xit 'when overriding home page' do
        cms_page = Cms::Page.create(name: 'home', path: '/', active: true)
        override_home_page(cms_page)

        visit '/'
        expect(page).to have_text 'homepage'

        cms_page.update active: false
        visit '/'
        expect(page).not_to have_text 'homepage'
      end
    end

    context 'with image_title_description_cta' do
      let(:component) { Cms::Component.find_by(name: 'image_title_description_cta') }

      it 'render correct content' do
        expect(page).to have_text 'content body'
      end
    end

    context 'with title_content_cta' do
      let(:component) { Cms::Component.find_by(name: 'title_content_cta') }

      it 'render correct title' do
        expect(page).to have_text 'title content'
      end

      it 'render correct content' do
        expect(page).to have_text 'content body'
      end
    end

    context 'with banner' do
      let(:component) { Cms::Component.find_by(name: 'banner') }

      before do
        2.times do
          sub_component.assets.create
        end
        visit '/random/page'
      end

      it 'render correct title' do
        expect(page).to have_text 'title content'
      end

      it 'render correct content' do
        expect(page).to have_text 'content body'
      end
    end
  end

  context 'with hero container' do
    let(:container) { Cms::Component.containers.find_by(name: 'hero_slider') }

    file_path = SolidusCms::Engine.root.join('spec/fixtures/images/logo.png')
    file_type = 'image/png'

    before do
      sub_component.metadata = { title: 'title content', content: 'content body' }
      sub_component.save
      asset = sub_component.assets.new
      asset.attachment = File.open(file_path)
      asset.save
      visit '/random/page'
    end

    context 'with hero_image' do
      let(:component) { Cms::Component.find_by(name: 'hero_image') }

      it 'render image correctly' do
        expect(page).to have_css ".image_hero_#{sub_component.assets.first.id}"
        expect(sub_component.assets.first.attachment_content_type).to eq(file_type)
      end
    end

    context 'with hero_image_title_content_cta' do
      let(:component) { Cms::Component.find_by(name: 'hero_image_title_content_cta') }

      it 'render correct title' do
        expect(page).to have_text 'title content'
      end

      it 'render correct content' do
        expect(page).to have_text 'content body'
      end
    end
  end
end
