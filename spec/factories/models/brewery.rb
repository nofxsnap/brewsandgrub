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

    remote_schedule_endpoint "http://livingthedreambrewing.com/events/?view=calendar&month=||MONTH-YYYY||"
    remote_endpoint_requires_date true
    schedule_scan_pattern '\|\|*.+\|\|'
    schedule_gsub_pattern '\|\|MONTH-YYYY\|\|'
  end

  factory :grist, class: Brewery do
    name "Grist Brewing Company"
    address_city "Highlands Ranch"
    address_state "Colorado"
    address_street "9150 Commerce Center Circle"
    address_zip "80129"
    description "Science balanced with creativity!"
    email "info@gristbrewingcompany.com"
    phone "(720) 360-4782"
    website "http://www.gristbrewingcompany.com"
    yelp_url "http://wtfyelpwhy.cn"

    remote_schedule_endpoint "https://www.gristbrewingcompany.com/events/?date=||M/D/YYYY||"
    remote_endpoint_requires_date true

    schedule_scan_pattern '\|\|*.+\|\|'
    schedule_gsub_pattern '\|\|M\/D\/YYYY\|\|'
  end
end
