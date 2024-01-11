# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Routes', type: :routing do
  describe 'when working with pages builder custom pages' do
    let(:page_route) do
      {
        controller: 'spree/solidus_cms/pages',
        action: 'show'
      }
    end

    context 'when trying to override an existing page' do
      let(:path) { '/super/page' }

      let(:super_page) { SolidusCms::Page.create(name: 'Super Page', path: path) }

      it 'responds with the custom page if it is enabled' do
        super_page.update(active: true)
        expect(get: path).to route_to(page_route.merge(path: 'super/page'))
      end

      it 'skips responding to the page if not enabled' do
        expect(get: path).not_to route_to(page_route)
      end
    end
  end
end
