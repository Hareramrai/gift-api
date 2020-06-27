# frozen_string_literal: true

class Employee < ApplicationRecord
  acts_as_taggable_on :interests

  has_one :gift, dependent: :nullify

  scope :without_gift, -> { left_joins(:gift).where(gifts: { employee_id: nil }) }

  validates :name, presence: true
end
