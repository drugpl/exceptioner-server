Rspec.configure do |config|
  # create user before(:each) or before(:all) ?
  config.before(:each) do
    @user = Test::User.new(:browser => self, :record => Factory(:user))
    @website = Test::Website.new(:browser => self)
  end
  config.after(:each) do
    @user.record.destroy
  end
end

module Test
  module Base
    extend ActiveSupport::Concern

    included do
      attr_accessor :browser
    end

    def initialize(options = {})
      @browser = options[:browser]
      yield if block_given?
      self
    end

    def expects(model_sym, method_sym, options = {})
      stub = Factory.stub(model_sym, options)
      model_sym.to_s.classify.constantize.should_receive(method_sym).and_return(stub)
      stub
    end
  end

  class User
    include Base

    attr_accessor :record

    def initialize(options = {})
      self.record = options[:record]
      super(options)
    end

    def click(*args)
      browser.click_link_or_button(*args)
      self
    end

    def fill_in(*args)
      browser.fill_in(*args)
      self
    end

    def fill_in_translated(*args)
      target = args.unshift
      browser.fill_in(I18n.t(target), *args)
    end

    def visit(path)
      browser.visit(path)
      self
    end

    def sign_in
      browser.visit browser.new_user_session_path
      browser.fill_in(I18n.t('activerecord.attributes.user.email'), :with => record.email)
      browser.fill_in(I18n.t('activerecord.attributes.user.password'), :with => record.password)
      browser.click_link_or_button(I18n.t('sign_in'))
      self
    end

    def create_project(args)
      browser.visit browser.new_project_path(self)
      browser.fill_in(I18n.t('activerecord.attributes.project.name'), :with => args[:name])
      browser.click_link_or_button(I18n.t('projects.add_user'))
      self
    end

    def should_see(*args)
      args.each do |arg|
        browser.page.should(browser.have_content(arg.to_s))
      end
      self
    end

    def should_not_see(*args)
      args.each do |arg|
        browser.page.should_not(browser.have_content(arg.to_s))
      end
      self
    end

    def should_see_translated(*args)
      args.each do |arg|
        should_see(I18n.t(arg.to_s))
      end
      self
    end

    def should_not_see_translated(*args)
      args.each do |arg|
        should_not_see(I18n.t(arg.to_s))
      end
      self
    end

    def click_translated(link)
      browser.click_link_or_button(I18n.t(link.to_s))
      self
    end

    def should_discover_rss(path)
      browser.page.should(browser.have_selector(%Q{link[rel="alternate"][type="application/rss+xml"][href="#{path}"]}))
      self
    end
  end

  class Website
    include Base

    def has(factory, options = {})
      Factory(factory, options)
    end
    def build(factory, options = {})
      Factory.build(factory, options)
    end
  end
end
