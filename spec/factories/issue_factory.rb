# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :issue do |f|
  f.name { %w(StandardError NoMoreDrugError ErrorError).sample }
  f.association :project
end
