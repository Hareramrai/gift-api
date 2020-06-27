# frozen_string_literal: true

require "rails_helper"

RSpec.describe Employees::AssignGiftService do
  include_context "sample employees and gifts data"

  subject { described_class.new(employee_id: employee_id) }

  describe "#call" do
    context "when employee doesn't exists" do
      let(:employee_id) { 9999 }

      it "raises EmployeeNotFound exception" do
        expect { subject.call }.to raise_error(Exceptions::EmployeeNotFound)
      end
    end

    context "When already assigned gift" do
      before do
        described_class.new(employee_id: oliver.id).call
      end

      let(:employee_id) { oliver.id }

      it "raises AlreadyAssignGift exception" do
        expect { subject.call }.to raise_error(Exceptions::AlreadyAssignGift)
      end
    end

    context "when employee exists but not assigned" do
      let(:employee_id) { oliver.id }

      it "assigns a gift to a given employee" do
        expect(oliver.gift).to be_blank
        subject.call
        expect(oliver.reload.gift).to be_present
      end
    end

    context "when gift already assigned to other employee" do
      let(:ram) { create(:employee, :game) }

      let(:employee_id) { ram.id }

      before do
        described_class.new(employee_id: oliver.id).call
      end

      it "raises GiftNotFound exception" do
        expect { subject.call }.to raise_error(Exceptions::GiftNotFound)
      end
    end
  end
end
