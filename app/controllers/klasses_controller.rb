# frozen_string_literal: true

class KlassesController < ApplicationController
  before_action :load_klass,
                only: %i[edit update toggle_active add_teachers do_add_teachers remove_teacher]

  def index
    @klasses = Klass.all.includes(:schedules).order(name: :asc)
    @klasses = @klasses.where('name LIKE ?', "%#{params[:q]}%") if params[:q]
    @klasses = @klasses.active unless params[:include_inactive]
  end

  def new
    @klass = Klass.new
  end

  def create
    @klass = Klass.new create_klass_params
    if @klass.save
      flash[:success] = 'Class created'
      redirect_to edit_klass_path(@klass)
    else
      flash.now[:danger] = 'Error creating class'
      render action: :new
    end
  end

  def edit
    @students = @klass.students.active
  end

  def update
    updated = @klass.update_attributes(update_klass_params)
    respond_to do |format|
      format.html do
        if updated
          flash[:notice] = 'Guardada'
        else
          flash[:alert] = 'Error'
        end
        redirect_to edit_klass_path(@klass)
      end
      format.js do
        if updated
          flash.now[:notice] = 'Guardada'
        else
          flash.now[:alert] = 'Error'
        end
      end
    end
  end

  def toggle_active
    @klass.toggle_active
    redirect_back fallback_location: klasses_path
  end

  def add_teachers
    @teachers = Person.active.teachers
  end

  def do_add_teachers
    selected_teachers = Person.where(id: params[:teacher_ids])
    @klass.teachers = selected_teachers
    @klass.save
    flash[:notice] = 'Teachers assigned'
    redirect_to edit_klass_path(@klass)
  end

  def remove_teacher
    teacher = Person.find(params[:teacher_id])
    @klass.teachers.delete(teacher)
    flash[:notice] = 'Teacher removed'
    redirect_to edit_klass_path(@klass)
  end

  private

  def create_klass_params
    params
      .require(:klass)
      .permit(:name, :status, :teacher_id, :fixed_fee, 
              schedules_attributes: %i[id from_time to_time day room_id _destroy])
  end

  def update_klass_params
    params
      .require(:klass)
      .permit(:name, :status, :teacher_id, :fixed_fee,
              schedules_attributes: %i[id from_time to_time day room_id _destroy])
  end

  def load_klass
    @klass = Klass.find(params[:id])
  end
end
