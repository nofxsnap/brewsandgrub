Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :breweries do
        resources :food_truck_calendars
        resources :menus
        resources :ratings
      end

      resources :food_trucks do
        resources :food_truck_calendars
        resources :menus
        resources :ratings
      end

      resources :food_truck_calendars

      resources :contacts
    end
  end
end
