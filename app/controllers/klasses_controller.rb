class KlassesController < ApplicationController
  before_action :load_klass, only: [:edit, :update, :toggle_active]

  def index
    @klasses = Klass.all.order('name ASC')
    @klasses = @klasses.where('name LIKE ?', "%#{params[:q]}%") if params[:q]
  end

  def new
    @klass = Klass.new
  end

  def create
    @klass = Klass.new create_klass_params
    if @klass.save
      redirect_to edit_klass_path(@klass)
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @klass.update_attributes(update_klass_params)
      flash[:notice] = 'Guardada'
    else
      flash[:alert] = 'Error'
    end
    render action: :edit
  end

  def toggle_active
    @klass.toggle_active
    redirect_back fallback_location: klasses_path
  end

private
  def create_klass_params
    params.require(:klass).permit(:name,:status,:teacher_id,:fixed_fee,schedules_attributes: [:id, :from_time, :to_time, :day, :_destroy])
  end

  def update_klass_params
    params.require(:klass).permit(:name,:status,:teacher_id,:fixed_fee,schedules_attributes: [:id, :from_time, :to_time, :day, :_destroy])
  end

  def load_klass
    @klass = Klass.find(params[:id])
  end
end
