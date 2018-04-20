class SettingsController < ApplicationController
  def save_setting
    Setting.set(params[:setting_key], params[:key][params[:setting_key]])
    redirect_back fallback_location: root_path
  end

  def options
  end

  def save_options
    params[:key].each do |k,v|
      Setting.set(k,v)
    end
    redirect_back fallback_location: options_path
  end
end
