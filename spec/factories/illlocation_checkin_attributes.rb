# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :illlocation_checkin_attribute, :class => 'CheckinAttribute' do
    checkin nil
    key "Last Comment"
    value "These tacos are tastey."
  end
end
