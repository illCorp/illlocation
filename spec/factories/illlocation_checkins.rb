# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :illlocation_checkin, :class => 'Illlocation::Checkin' do
    locatable_id 1
    locatable_type "User"
    latitude "39.9319"
    longitude "105.0658"
  end
end
