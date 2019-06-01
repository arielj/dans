class PackagesController < ApplicationController
  before_action :load_package, only: [:edit, :update]

  def index
    @packages = Package.all.includes(:klasses).order('name ASC')
    unless params[:include_personal_packages].present?
      @packages = @packages.where(person_id: 0).where.not('name LIKE "Clases ____ %"')
    end
    @packages = @packages.where('name LIKE ?', "%#{params[:q]}%") if params[:q]
  end

  def new
    @package = Package.new
  end

  def create
    @package = Package.new create_package_params
    if @package.save
      flash[:success] = "Package created"
      redirect_to edit_package_path(@package)
    else
      flash.now[:danger] = "Error creating package"
      render action: :new
    end
  end

  def edit
    @students = @package.students.active
  end

  def update
    updated = @package.update_attributes(update_package_params)
    respond_to do |format|
      format.html {
        if updated
          flash[:notice] = 'Guardado'
        else
          flash[:alert] = 'Error'
        end
        redirect_to edit_package_path(@package)
      }
      format.js {
        if updated
          flash.now[:notice] = 'Guardado'
        else
          flash.now[:alert] = 'Error'
        end
      }
    end
  end

private
  def create_package_params
    params.require(:package).permit(:name,:fee)
  end

  def update_package_params
    params.require(:package).permit(:name,:fee)
  end

  def load_package
    @package = Package.find(params[:id])
  end
end
