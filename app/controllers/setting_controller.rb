class SettingController < ApplicationController
  def save
    params[:key].each do |k,v|
      Setting.set(k,v)
    end
    redirect_back fallback_location: root_path
  end
end
