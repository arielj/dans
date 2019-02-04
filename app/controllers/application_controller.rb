class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_admin!
  before_action :set_locale

  def set_locale
    I18n.locale = Setting.fetch('language','es')
  end
end
