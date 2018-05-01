module ApplicationHelper

  def title(page_title)
    content_for(:title) {page_title}
  end

  def sidebar_item(text, path, options=nil)
    options ||= {}
    content_tag :li, class: "nav-item #{active_path(path)}"  do
       link_to path,class:'nav-link' do
          content_tag(:i,nil,class: options[:icon_class] || 'icon-star')+
          text
       end
    end
  end

  def link_button(name, title, options=nil)
    options ||= {}
    options[:method] ||= nil
    options[:data] ||= {}
    options[:button_class] ||= 'btn-default'

    if options[:method] == :delete && options[:data][:confirm].nil?
      options[:data][:confirm] = 'Are you sure?'
    end

    link_to(name, method: options[:method], data: options[:data], class: "btn btn-xs #{options[:button_class]}", 'data-toggle' => 'tooltip', 'data-placement' => 'top', title: title) do
      content_tag(:i, nil, class: "fa #{options[:icon_class]}")
    end
  end

  def crud_links(entity)

    edit_path = Rails.application.routes.url_helpers.send("edit_#{entity.class.name.underscore}_path", entity.id)
    link_button(edit_path, 'Edit', button_class: 'btn-info', icon_class: 'fa-pencil') +
        link_button(entity, 'Delete', button_class: 'btn-danger', icon_class: 'fa-trash', method: :delete)

  end

  def active_path(path)
    current_route = Rails.application.routes.recognize_path(path)
    'active' if current_page?(path) or params[:controller] == current_route[:controller]
  end

end
