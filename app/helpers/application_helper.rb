# frozen_string_literal: true

module ApplicationHelper
  def page_title(value)
    content_for :page_title do
      value
    end
  end
end
