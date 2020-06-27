# frozen_string_literal: true

EMPLOYEES_FILE_PATH = Rails.root.join('db', 'data', 'employees.json')
GIFTS_FILE_PATH = Rails.root.join('db', 'data', 'gifts.json')

unless Employee.any?
  employee_list = JSON.parse(File.read(EMPLOYEES_FILE_PATH), { symbolize_names: true })
  employee_list.each do |employee_params|
    Employee.new.tap do |employee|
      employee.name = employee_params[:name]
      employee.interest_list = employee_params[:interests]
      employee.save!
    end
  end
end

unless Gift.any?
  gift_list = JSON.parse(File.read(GIFTS_FILE_PATH), { symbolize_names: true })

  gift_list.each do |gift_params|
    Gift.new.tap do |gift|
      gift.name = gift_params[:name]
      gift.category_list = gift_params[:categories]
      gift.save!
    end
  end
end
