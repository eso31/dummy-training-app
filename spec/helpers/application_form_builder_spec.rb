require 'rails_helper'


describe ApplicationFormBuilder do
  let(:resource) {FactoryBot.build(:training_request, name: 'RUBY 101')}
  let(:builder) {ApplicationFormBuilder.new :training_request, resource, self, {}}
  describe '#text_field' do
    let(:output) do
      builder.text_field :name
    end
    it {
      expect(output).to have_tag('div', with: {class: 'form-group'}) do
        with_tag 'label', with: {class: 'col-sm-12 control-label', for: 'training_request_name'} do
          with_text 'Name'
        end

        with_tag 'div', with: {class: 'col-sm-12'} do
          with_tag 'input', with: {type: 'text', value: 'RUBY 101', name: 'training_request[name]', id: 'training_request_name'}
        end
        # without_tag 'div', with: {class: 'form-group'}

      end
    }
  end


  describe '#datepicker' do
    let(:output) do
      builder.datepicker :start_date
    end
    it {
      expect(output).to have_tag('div', with: {class: 'form-group'}) do
        with_tag 'label', with: {class: 'col-sm-12 control-label', for: 'training_request_start_date'} do
          with_text 'Start date'
        end
        with_tag 'div', with: {class: 'col-sm-12'} do
          with_tag 'input', with: {class: 'form-control datepicker', type: 'text', name: 'training_request[start_date]', id: 'training_request_start_date'}
        end

      end
    }
  end


  describe '#autocomplete' do
    let(:output) do
      builder.autocomplete :assigned_to_user
    end
    it {
      expect(output).to have_tag('div', with: {class: 'form-group'}) do
        with_tag 'label', with: {class: 'col-sm-12 control-label', for: 'training_request_assigned_to_user'} do
          with_text 'Assigned to user'
        end
        with_tag 'div', with: {class: 'col-sm-12'} do
          with_tag 'select', with: {class: 'form-control', id: 'assigned_to_user'}
          with_tag 'input', with: {
              name: 'training_request[assigned_to_user_id]',
              id: 'training_request_assigned_to_user_id',
              class: 'selected_id',
              type: 'hidden'
          }
        end

      end
    }
  end
end