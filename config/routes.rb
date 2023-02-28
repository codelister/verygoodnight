Rails.application.routes.draw do
    resources :users, only: [:index, :show, :create] do
        resources :sleep_records, only: [:index, :create, :update]
        resources :user_follows, only: [:create]
        get "/user_follows/followers", to: "user_follows#followers"
        get "/user_follows/followees", to: "user_follows#followees"
        delete "/user_follows", to: "user_follows#destroy"
        get "/user_follows/sleep_records", to: "user_follows#followers_sleep_records"
    end
end
