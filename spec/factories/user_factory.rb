# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :user do |f|
  f.sequence(:email) { |n| "rubist#{n}@drug.org.pl" }
  f.password "mysecretpassword"
end
