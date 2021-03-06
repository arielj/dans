# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_admin!
  before_action :set_locale
  before_action :set_paper_trail_whodunnit

  def set_locale
    I18n.locale = Setting.fetch('language', 'es')
  end

  def user_for_paper_trail
    current_admin&.id
  end

  def allow_only_admin
    unless current_admin&.admin?
      redirect_to root_path and return false
    end
  end
end
