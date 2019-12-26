# frozen_string_literal: true

module SortableHelper
  def sortable_link(column, label = nil)
    label ||= sortable_class.human_attribute_name(column)
    css_class = column == sort_column ? "current_sort #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to label, { sort: column, direction: direction }, class: css_class
  end

  def sort_column
    sortable_class.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sortable_class_str
    cls = is_a?(ApplicationController) ? self : controller
    cls.class.to_s.gsub(/(.*)Controller\z/, '\1').singularize
  end

  def sortable_class
    sortable_class_str.constantize
  end

  def get_sorted(*default)
    if sort_column =~ /\A(.*)_id\z/
      method = "sort_by_#{$1}"
      return sortable_class.send(method, sort_direction) if sortable_class.respond_to?(method)
    end

    if sort_column
      sortable_class.order(sort_column => sort_direction)
    else
      sortable_class.order(default)
    end
  end
end
