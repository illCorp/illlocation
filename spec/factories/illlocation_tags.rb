# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :illlocation_tag, :class => 'IlllocationTags' do
    location nil
    tag "Restaurant"
  end
end
