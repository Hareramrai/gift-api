# frozen_string_literal: true

class Gift < ApplicationRecord
  acts_as_taggable_on :categories

  belongs_to :employee, optional: true

  scope :unassigned_gifts, -> { where(employee_id: nil) }

  validates :name, presence: true
end
