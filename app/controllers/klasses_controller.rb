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
    @year = (params[:year] || DateTime.current.year).to_i
    @month = params[:month] || Installment.months_for_select[DateTime.current.month - 1].last
    @students = klass.students_for_year_and_month(@year, @month)
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

  def export_students
    send_file ExcelExporter.to_xls(klass.students_for_year(params[:year]).order(:name, :lastname))
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
