# frozen_string_literal: true

class Employees::GiftFinderService
  def initialize(employee:)
    @employee = employee
  end

  def call
    gifts = pending_gifts_with_related_interests(interests: my_uniq_interests)

    if my_uniq_interests.present? && gifts.present?
      gifts.first
    else
      find_gift_from_related_employees
    end
  end

  def find_gift_from_related_employees
    gifts_success_serving = generate_gift_success_serving_map

    maximize_for_better_gift_allocation(gifts_success_serving: gifts_success_serving)
  end

  private

    attr_reader :employee

    def pending_gifts_with_related_interests(interests:)
      Gift.includes(:categories).unassigned_gifts.tagged_with(interests, any: true)
    end

    def my_uniq_interests
      @my_uniq_interests ||= employee_interests - related_employees_interests
    end

    def employee_interests
      @employee_interests ||= employee.interest_list
    end

    def related_employees_interests
      @related_employees_interests ||= pending_employees_with_related_interests
                                       .map(&:interest_list).flatten
    end

    # this doesn't include the given employee
    def pending_employees_with_related_interests
      @pending_employees_with_related_interests ||= begin
        related_employee_ids = employee.find_related_interests.map(&:id)
        Employee.includes(:interests).without_gift.where(id: related_employee_ids)
      end
    end

    def generate_gift_success_serving_map
      gifts_success_serving = {}
      gift_stock.each do |gift|
        next unless matched_my_interest?(gift)

        gifts = gift_stock - [gift]
        gifts_success_serving[gift] = possible_to_serve_pending_employees_with_the_gifts(
          gifts: gifts
        )
      end

      gifts_success_serving
    end

    def gift_stock
      @gift_stock ||= pending_gifts_with_related_interests(
        interests: employee_interests + related_employees_interests
      )
    end

    def matched_my_interest?(gift)
      (employee_interests & gift.category_list).present?
    end

    # returns zero when all other employees can get the gift
    # otherwise returns number of employee who won't able to get the gift
    def possible_to_serve_pending_employees_with_the_gifts(gifts:)
      failed_to_serve = 0
      blocked_gifts = []
      pending_employees_with_related_interests.each do |other_employee|
        able_to_get_gift = false
        gifts.each do |gift|
          if can_block_gift_for_employee?(blocked_gifts, gift, other_employee)
            able_to_get_gift = true
            blocked_gifts << gift.id
          end
        end
        failed_to_serve += 1 unless able_to_get_gift
      end

      failed_to_serve
    end

    def can_block_gift_for_employee?(blocked_gifts, gift, other_employee)
      !blocked_gifts.include?(gift.id) &&
        (other_employee.interest_list & gift.category_list)
    end

    # will try cover as much as possibe to cover employee
    # lowest value of hash will cover maximum employee if select
    # gift in the key
    def maximize_for_better_gift_allocation(gifts_success_serving:)
      gifts_success_serving.min_by { |_key, value| value }&.first
    end
end
