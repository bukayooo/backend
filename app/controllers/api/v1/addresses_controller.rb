class Api::V1::AddressesController < ApplicationController
  def index
    addresses = Address.all
    render json: addresses
  end

  def create
    address = Address.new(address_params)
    if address.save
      render json: address, status: :created
    else
      render json: address.errors, status: :unprocessable_entity
    end
  end

  def set_selected
    address = Address.find(params[:id])
    Address.update_all(selected: false)
    address.update(selected: true)
    render json: address
  end

  private

  def address_params
    params.require(:address).permit(:full_address, :label)
  end
end