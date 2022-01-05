# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cms::ComponentsPage, type: :model do
  let!(:page) { create(:page) }

  describe '#move_to' do
    let!(:first_component) { page.components_pages.top_level.first }
    let!(:second_component) { page.components_pages.top_level.second }

    context 'when moving top level components' do
      before do
        second_component.move_to(1)
      end

      it 'moves the last element to the first spot' do
        expect(second_component.reload.position).to be(1)
      end

      it 'moves the first element to last spot' do
        expect(first_component.reload.position).to be(2)
      end
    end

    context 'when moving children components' do
      let!(:first_sub_component) { first_component.children.first }
      let!(:last_sub_component) { first_component.children.last }

      it 'moves the last element to the first spot' do
        last_sub_component.move_to(1)
        expect(first_sub_component.reload.position).to be(2)
      end
    end

    context 'when creating a new component' do
      it 'adds it to the end' do
        component = page.components_pages.create(name: 'Testing',
          component: Cms::Component.containers.first)
        expect(component.position).to be(3)
      end
    end

    context 'when creating a new child component' do
      it 'adds it to the end' do
        component = first_component.children.create(name: 'Testing',
          component: Cms::Component.content.first,
          page: page)
        expect(component.position).to be(first_component.children.reload.last.position)
      end
    end
  end

  describe '#update_related_positions' do
    let!(:first_component) { page.components_pages.top_level.first }
    let!(:second_component) { page.components_pages.top_level.second }
    let!(:first_first_sub_component) { first_component.children.first }
    let!(:first_last_sub_component) { first_component.children.last }
    let!(:second_first_sub_component) { second_component.children.first }

    it 'update positions in related components' do
      expect do
        first_component.update_related_positions
        second_component.reload
      end.to change(second_component, :position).by(-1)
    end

    context 'with children sub components' do
      it 'update related children components position correctly' do
        expect do
          first_first_sub_component.update_related_positions
          first_last_sub_component.reload
        end.to change(first_last_sub_component, :position).by(-1)
      end

      it 'doesnt update other component children' do
        expect do
          first_first_sub_component.update_related_positions
          second_first_sub_component.reload
        end.not_to change(second_first_sub_component, :position)
      end
    end
  end
end
