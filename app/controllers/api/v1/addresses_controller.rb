class Api::V1::AddressesController < ApplicationController
  def index
    addresses = Address.all
    render json: addresses
  end

  def create
    Rails.logger.info "Received params: #{params.inspect}"
    address = Address.new(address_params)
    address.selected = true if Address.count.zero? || !Address.exists?(selected: true)
    
    if address.save
      render json: address, status: :created
    else
      Rails.logger.error "Address save failed: #{address.errors.full_messages}"
      render json: { errors: address.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error "Error in create action: #{e.message}"
    render json: { error: e.message }, status: :internal_server_error
  end

  def destroy
    address = Address.find(params[:id])
    if address.destroy
      render json: { success: true }
    else
      render json: { success: false, error: 'Failed to delete address' }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { success: false, error: 'Address not found' }, status: :not_found
  end

  def set_selected
    address = Address.find(params[:id])
    if address
      Address.update_all(selected: false)
      address.update(selected: true)
      render json: { success: true, address: address }
    else
      render json: { success: false, error: 'Address not found' }, status: :not_found
    end
  rescue => e
    render json: { success: false, error: e.message }, status: :internal_server_error
  end

  private

  def address_params
    params.require(:address).permit(:full_address, :label, :bedrooms, :bathrooms)
  end
end