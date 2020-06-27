# frozen_string_literal: true

RSpec.shared_context "sample employees and gifts data" do
  let!(:oliver) { create(:employee, :song_cricket_game) }
  let!(:henry) { create(:employee, :song) }
  let!(:hare) { create(:employee, :cricket) }

  let!(:bat) { create(:gift, :cricket) }
  let!(:gaana) { create(:gift, :song) }
  let!(:xbox) { create(:gift, :game) }
end
