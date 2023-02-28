Rails.application.routes.draw do
    resources :users, only: [:index, :show, :create] do
        resources :sleep_records, only: [:index, :create, :update]
    end
end
