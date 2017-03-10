Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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

  resources :contacts
end
