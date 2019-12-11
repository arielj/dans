# frozen_string_literal: true

class SettingsController < ApplicationController
  def save_setting
    Setting.set(params[:setting_key], params[:key][params[:setting_key]])

    respond_to do |format|
      format.html do
        flash[:success] = 'Guardado'
        redirect_back fallback_location: root_path
      end

      format.js do
        flash.now[:success] = 'Guardado'
      end
    end
  end

  def options
    @fees = Setting.fetch('hour_fees', {})
  end

  def save_options
    params[:key].each do |k, v|
      v = v.permit!.to_h if k == 'hour_fees'
      Setting.set(k, v)
    end

    flash[:success] = 'Configuración guardada'
    redirect_back fallback_location: settings_path
  end

  def add_price; end
end
