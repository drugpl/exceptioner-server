# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :project do |f|
  f.sequence(:name) { |n| "Project  #{n}" }
  f.api_token "1234567890"
end
