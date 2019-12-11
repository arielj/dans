# frozen_string_literal: true

class PackagesController < ApplicationController
  def index
    @packages = Package.all.includes(:klasses).order(name: :asc)
    if params[:include_personal_packages].present?
      @packages = @packages.where(person_id: 0).where.not('name LIKE "Clases ____ %"')
    end
    @packages = @packages.where('name LIKE ?', "%#{params[:q]}%") if params[:q]
  end

  def export
    packages = Package.all.includes(:klasses).order(name: :asc)
    if params[:include_personal_packages].present?
      packages = packages.where(person_id: 0).where.not('name LIKE "Clases ____ %"')
    end
    packages = packages.where('name LIKE ?', "%#{params[:q]}%") if params[:q]

    send_file ExcelExporter.to_xls(packages)
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package.new create_package_params
    if @package.save
      flash[:success] = 'Package created'
      redirect_to edit_package_path(@package)
    else
      flash.now[:danger] = 'Error creating package'
      render action: :new
    end
  end

  def edit
    find_package
    @students = @package.students.active
  end

  def update
    find_package
    updated = @package.update_attributes(update_package_params)
    respond_to do |format|
      format.html do
        if updated
          flash[:notice] = 'Guardado'
        else
          flash[:alert] = 'Error'
        end
        redirect_to edit_package_path(@package)
      end
      format.js do
        if updated
          flash.now[:notice] = 'Guardado'
        else
          flash.now[:alert] = 'Error'
        end
      end
    end
  end

  def destroy
    find_package
    @package.destroy
    flash[:success] = t('destroyed.package')
    redirect_to action: :index
  end

  private

  def create_package_params
    params.require(:package).permit(:name, :fee, schedule_ids: [])
  end

  def update_package_params
    params.require(:package).permit(:name, :fee, schedule_ids: [])
  end

  def find_package
    @package = Package.find(params[:id])
  end
end
