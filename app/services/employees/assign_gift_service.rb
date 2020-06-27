# frozen_string_literal: true

class Employees::AssignGiftService
  def initialize(employee_id:)
    @employee = Employee.find_by id: employee_id
    @gift_finder = Employees::GiftFinderService.new(employee: employee)
  end

  def call
    raise Exceptions::EmployeeNotFound unless employee
    raise Exceptions::AlreadyAssignGift if employee.gift

    gift = @gift_finder.call

    raise Exceptions::GiftNotFound unless gift && gift.employee_id.blank?

    gift.with_lock do
      gift.update!(employee: employee)
    end

    gift
  end

  private

    attr_reader :employee
end
