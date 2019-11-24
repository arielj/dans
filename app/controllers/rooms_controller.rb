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
      flash[:success] = 'Sala creada'
      redirect_to edit_room_path(@room)
    else
      flash.now[:error] = 'Error al crear sala, revisá los campos'
      render action: :new
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    @room.attributes = room_params
    if @room.save
      flash[:success] = 'Sala actualizada'
      redirect_to edit_room_path(@room)
    else
      flash.now[:error] = 'Error al guardarsala, revisá los campos'
      render action: :new
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
