# frozen_string_literal: true

require 'spec_helper'

describe 'Pages Builder', type: :feature, js: true do
  describe 'as admin user' do
    stub_authorization!

    before do
      visit spree.admin_path
    end

    it 'has a link to page builder' do
      expect(page).to have_link('Pages Builder')
    end

    it 'allow create new page' do
      expect {
        click_on 'Pages Builder'
        click_on 'New Page'
        fill_in 'page_name', with: 'Test'
        fill_in 'page_path', with: '/test'
        click_on 'Create Page'
      }.to change { Cms::Page.count }.by(1)
    end
  end
end
