# frozen_string_literal: true

require 'action_view'
class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::FormTagHelper

  delegate :content_tag, to: :@template

  FIELD_HELPERS = %w[text_field number_field check_box text_area email_field password_field].freeze

  FIELD_HELPERS.each do |method_name|
    define_method(method_name) do |name, options = {}|
      options = { label: name }.merge(options)
      label_and_wrapper(self, options[:label], options) do
        options[:class] ||= 'form-control'
        super(name, options)
      end
    end
  end

  def datepicker(name, options = {})
    options[:class] = 'form-control datepicker'
    text_field name, options
  end

  def datetimepicker(name, options = {})
    classes = 'form-control input-append date form_datetime'

    options[:class] = if options[:class]
                        options[:class] + classes
                      else
                        classes
                      end

    text_field name, options
  end

  # method(:foo).super_method.call

  def autocomplete(name, options = {})
    # TODO: Refactor this
    field_name = nil
    options = { label: name }.merge(options)
    label_and_wrapper(self, options[:label], options) do
      options = { option_text_method: 'to_s' }.merge(options)
      selected_entity = object.send(name)
      if selected_entity
        if selected_entity.respond_to?(:each)
          options = options_from_collection_for_select(selected_entity, 'id', options[:option_text_method], selected_entity.ids)
          multiple = true
          selector = "#{object_name}[#{name.to_s.singularize}_ids][]"
          field_name = selector
          value = nil
        else
          selector = "#{object_name}[#{name}_id]"
          mutiple = false
          options = options_from_collection_for_select([selected_entity], 'id', options[:option_text_method], selected_entity.id)
          value = selected_entity.id
        end
      else
        options = nil
        selector = "#{object_name}[#{name}_id]"
        multiple = false
        value = nil
      end
      select_tag(field_name, options, id: name, multiple: multiple, class: 'form-control') +
        hidden_field_tag(selector, value, class: 'selected_id')
    end
  end

  private

  def label_and_wrapper(f, label, options = {}, &content)
    options = {
      use_div_wrapper: true,
      label_classes: 'col-sm-12',
      field_classes: 'col-sm-12'
    }.merge(options)

    field_and_label = lambda {
      f.label(label, class: "#{options[:label_classes]} control-label") +
        content_tag(:div, class: options[:field_classes], &content)
    }

    if options[:use_div_wrapper]
      content_tag(:div, nil, class: 'form-group', &field_and_label)
    else
      field_and_label.call
    end
  end
end
