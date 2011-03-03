# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :project_user do |f|
  f.association :project
  f.association :user
end
