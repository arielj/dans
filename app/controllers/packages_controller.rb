# typed: true
# frozen_string_literal: true

class PackagesController < ApplicationController
  def index
    @packages = Package.all.includes(:klasses).order(name: :asc)
    # @packages = @packages.not_personal unless params[:include_personal_packages].present?
    @packages = @packages.search(params[:q]) if params[:q]
  end

  def export
    index
    send_file ExcelExporter.to_xls(@packages)
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package.new create_package_params
    if @package.save
      redirect_to edit_package_path(@package), notice: t('created.package')
    else
      flash.now[:error] = 'Error creating package'
      render action: :new
    end
  end

  def edit
    @students = package.students.active
  end

  def update
    updated = package.update_attributes(update_package_params)
    respond_to do |format|
      format.html do
        if updated
          flash[:notice] = 'Guardado'
        else
          flash[:error] = 'Error'
        end
        redirect_to edit_package_path(package)
      end
      format.js do
        if updated
          flash.now[:notice] = 'Guardado'
        else
          flash.now[:error] = 'Error'
        end
      end
    end
  end

  def destroy
    package.destroy

    flash[:notice] = t('destroyed.package')
    redirect_to action: :index
  end

  def package
    @package ||= Package.find(params[:id])
  end
  helper_method :package

  private

  def create_package_params
    params.require(:package).permit(:name, :fee, schedule_ids: [])
  end

  def update_package_params
    params.require(:package).permit(:name, :fee, schedule_ids: [])
  end
end
