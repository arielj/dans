# typed: true
# frozen_string_literal: true

class KlassesController < ApplicationController
  def index
    @klasses = Klass.all.includes(:schedules).order(name: :asc)
    @klasses = @klasses.search(params[:q]) if params[:q]
    @klasses = @klasses.active unless params[:include_inactive]
  end

  def export
    index
    send_file ExcelExporter.to_xls(@klasses)
  end

  def new
    @klass = Klass.new
  end

  def create
    @klass = Klass.new create_klass_params
    if @klass.save
      redirect_to edit_klass_path(@klass), notice: t('created.klass')
    else
      flash.now[:error] = 'Error creating class'
      render action: :new
    end
  end

  def edit
    @students = klass.students.active
  end

  def update
    updated = klass.update_attributes(update_klass_params)
    respond_to do |format|
      format.html do
        if updated
          flash[:notice] = 'Guardada'
        else
          flash[:error] = 'Error'
        end
        redirect_to edit_klass_path(klass)
      end
      format.js do
        if updated
          flash.now[:notice] = 'Guardada'
        else
          flash.now[:error] = 'Error'
        end
      end
    end
  end

  def toggle_active
    klass.toggle_active

    redirect_back fallback_location: klasses_path
  end

  def assign_teachers
    @teachers = Person.active.teachers
  end

  def do_assign_teachers
    selected_teachers = Person.where(id: params[:teacher_ids])
    klass.teachers = selected_teachers
    klass.save

    redirect_to edit_klass_path(klass), notice: t('assigned.teachers')
  end

  def remove_teacher
    teacher = Person.find(params[:teacher_id])
    klass.teachers.delete(teacher)

    redirect_to edit_klass_path(klass), notice: tg('removed.teacher', teacher.gender)
  end

  def export_students
    send_file ExcelExporter.to_xls(klass.students)
  end

  def klass
    @klass ||= Klass.find(params[:id])
  end
  helper_method :klass

  private

  def create_klass_params
    params
      .require_typed(:klass, TA[ActionController::Parameters].new)
      .permit(:name, :status, :fixed_fee, :non_regular_fee, teacher_ids: [],
              schedules_attributes: %i[id from_time to_time day room_id _destroy])
  end

  def update_klass_params
    params
      .require_typed(:klass, TA[ActionController::Parameters].new)
      .permit(:name, :status, :fixed_fee, :non_regular_fee, teacher_ids: [],
              schedules_attributes: %i[id from_time to_time day room_id _destroy])
  end
end
