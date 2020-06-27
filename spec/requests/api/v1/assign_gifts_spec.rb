# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::AssignGifts", type: :request do
  include_context "sample employees and gifts data"

  describe "POST /api/v1/assign_gifts" do
    context "when employee exists but not assigned" do
      let(:employee_id) { oliver.id }

      before do
        post api_v1_employee_assign_gifts_path(employee_id: employee_id)
      end

      it "assigns a gift to a given employee" do
        expect(response).to have_http_status(200)
        expect(oliver.reload.gift).to be_present
      end
    end

    context "when gift already assigned to other employee" do
      let(:ram) { create(:employee, :game) }

      let(:employee_id) { ram.id }

      before do
        Employees::AssignGiftService.new(employee_id: oliver.id).call

        post api_v1_employee_assign_gifts_path(employee_id: employee_id)
      end

      it "raises GiftNotFound exception" do
        expect(response).to have_http_status(404)
        expect(response.body).to include("We are out of stock, better luck next time")
      end
    end
  end
end
