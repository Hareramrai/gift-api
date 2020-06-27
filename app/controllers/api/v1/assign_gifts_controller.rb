# frozen_string_literal: true

class Api::V1::AssignGiftsController < Api::V1::BaseController
  def create
    @gift = Employees::AssignGiftService.new(employee_id: params[:employee_id]).call

    render json: @gift
  end
end
