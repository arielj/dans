# frozen_string_literal: true

class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:success] = t('saved.room')
      redirect_to edit_room_path(@room)
    else
      flash.now[:error] = 'Error al crear sala, revisá los campos'
      render action: :new
    end
  end

  def edit
    find_room
  end

  def update
    find_room
    @room.attributes = room_params
    if @room.save
      flash[:success] = t('saved.room')
      redirect_to edit_room_path(@room)
    else
      flash.now[:error] = 'Error al guardarsala, revisá los campos'
      render action: :new
    end
  end

  def destroy
    find_room
    @room.destroy
    flash[:success] = t('destroyed.room')
    redirect_to action: :index
  end

  def export
    send_file ExcelExporter.to_xls(Room.all)
  end

  private

  def find_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
