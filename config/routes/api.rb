# frozen_string_literal: true

namespace :api, defaults: { format: :json } do
  namespace :v1 do
    resources :employees, only: [] do
      resources :assign_gifts, only: :create
    end
  end
end
