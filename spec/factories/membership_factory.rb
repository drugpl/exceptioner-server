# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :membership do |f|
  f.association :project
  f.association :user
end
