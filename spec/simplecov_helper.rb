# frozen_string_literal: true

if ENV["SIMPLECOV"]
  require "simplecov"
  SimpleCov.start "rails" do
    add_filter do |source_file|
      source_file.lines.count < 7
    end
  end
  puts "Collecting coverage report..."
end
