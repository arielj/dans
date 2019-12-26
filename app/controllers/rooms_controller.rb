# frozen_string_literal: true

class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def export
    index
    send_file ExcelExporter.to_xls(@rooms)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to edit_room_path(@room), notice: t('saved.room')
    else
      flash.now[:error] = 'Error al crear sala, revisá los campos'
      render action: :new
    end
  end

  def edit; end

  def update
    room.attributes = room_params
    if room.save
      redirect_to edit_room_path(@room), notice: t('saved.room')
    else
      flash.now[:error] = 'Error al guardarsala, revisá los campos'
      render action: :new
    end
  end

  def destroy
    room.destroy

    flash[:notice] = t('destroyed.room')
    redirect_to action: :index
  end

  def room
    @room ||= Room.find(params[:id])
  end
  helper_method :room

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
