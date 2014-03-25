# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :illlocation_checkin, :class => 'Illlocation::Checkin' do
    location factory: :illlocation_location
    locatable_id 1
    locatable_type "User"
  end
end
