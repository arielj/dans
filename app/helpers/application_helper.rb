# frozen_string_literal: true

module ApplicationHelper
  def page_title(value)
    content_for :page_title do
      value
    end
  end

  def render_flash_message(key)
    aux = case key
          when 'notice', :notice then :success
          when 'alert', :alert then :error
          else key
          end

    content_tag 'div', class: "toast toast-#{aux}" do
      concat tag.button(class: 'btn btn-clear float-right')
      concat flash[key]
    end
  end
end
