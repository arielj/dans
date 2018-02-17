class KlassesController < ApplicationController
  def index
    @klasses = Klass.all.order('name ASC')
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
    @klass = Klass.find(params[:id])
  end

  def update
    @klass = Klass.find(params[:id])
    if @klass.update_attributes(update_klass_params)
      flash[:notice] = 'Guardada'
    else
      flash[:alert] = 'Error'
    end
    render action: :edit
  end

private
  def create_klass_params
    params.require(:klass).permit(:name,:status,:teacher_id,:fixed_fee,schedules_attributes: [:id, :from_time, :to_time, :day, :_destroy])
  end

  def update_klass_params
    params.require(:klass).permit(:name,:status,:teacher_id,:fixed_fee,schedules_attributes: [:id, :from_time, :to_time, :day, :_destroy])
  end
end
