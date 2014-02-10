# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :illlocation_location, :class => 'Illlocation::Location' do
    latitude "39.9319"
    longitude "105.0658"
    altitude "1724"    
  end
end
