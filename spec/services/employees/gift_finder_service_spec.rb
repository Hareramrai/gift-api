# frozen_string_literal: true

require "rails_helper"

RSpec.describe Employees::GiftFinderService do
  include_context "sample employees and gifts data"

  describe "#call" do
    context "won't blocks other employee" do
      subject { described_class.new(employee: oliver) }

      it "should not returns cricket or song becuase it blocks other" do
        expect(subject.call).to eq(xbox)
      end
    end

    context "cover maximum employees" do
      let!(:alex) { create(:employee, :book_song) }
      let!(:ruby_book) { create(:gift, :book) }

      context "success scenario" do
        subject { described_class.new(employee: alex) }

        it "finds gift for all employees" do
          gift1 = described_class.new(employee: oliver).call
          gift1.update(employee: oliver)

          gift2 = described_class.new(employee: henry).call
          gift2.update(employee: henry)

          gift3 = described_class.new(employee: hare).call
          gift3.update(employee: hare)

          expect(subject.call).to eq(ruby_book)
          expect(ruby_book.reload.employee).to be_blank

          ruby_book.update(employee: alex)

          expect(Gift.unassigned_gifts).to be_blank
        end
      end

      # suppose if didn't assign it correctly
      # will simulate few wrong assignment then we will see the result
      context "failure scenario" do
        before do
          bat.update(employee: oliver)
          gaana.update(employee: alex)
        end

        it "won't able to provide gift to all remaining employee" do
          expect(described_class.new(employee: henry).call).to be_blank
          expect(described_class.new(employee: hare).call).to be_blank
        end
      end
    end
  end
end
