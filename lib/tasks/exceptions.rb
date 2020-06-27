# frozen_string_literal: true

module Exceptions
  class EmployeeNotFound < StandardError
    def message
      "Employee with requested id doesn't exists."
    end
  end

  class GiftNotFound < StandardError
    def message
      "We are out of stock, better luck next time."
    end
  end

  class AlreadyAssignGift < StandardError
    def message
      "You have already got one."
    end
  end
end
