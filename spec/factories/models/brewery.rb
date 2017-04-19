# Factory girl instance for breweries
FactoryGirl.define do
  factory :living_the_dream, class: Brewery do
    name "Living the Dream"
    address_city "Littleton"
    address_state "Colorado"
    address_street "12305 Dumont Way, Unit A"
    address_zip "80125"
    description "We are a dog friendly brewery & taproom located in Highlands Ranch, Colorado."
    email "info@livingthedreambrewing.com"
    phone "(303) 284-9585"
    website "http://livingthedreambrewing.com"
    yelp_url "http://whydopeopleuseyelp.com"
    food_truck_id nil

    remote_schedule_endpoint "http://livingthedreambrewing.com/events/?view=calendar&month=||MONTH-YYYY||"
    remote_endpoint_requires_date true
  end
end
