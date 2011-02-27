require 'spec_helper'

describe Api::IssuesController do
  context "POST #create" do
    before :all do
      @project = Factory(:project)
    end

    it "should require valid api key" do
      post :create, :version => "0.1", :issue => {}, :format => "json"
      response.should be_forbidden
      response.body.should == {'api_key' => 'invalid api key'}.to_json
    end

    it 'should require valid version' do
      request.env['API-Key'] = @project.api_token
      post :create, :version => '1.0', :issue => {}, :format => 'json'
      response.should be_not_found
      response.body.should == {'api_version' => 'unknown api version'}.to_json
    end

    context 'with valid API key and version' do
      before do
        request.env['API-Key'] = @project.api_token
      end

      context 'with valid issue data' do
        before do
          post :create, :format => 'json', :version => '0.1', :issue => {
            :name => 'TestError', :message => 'Error occurred.'
          }
        end

        subject { response }
        it { should be_success }
        its(:body) { should == Issue.last.to_json }
      end

      context 'with invalid issue data' do
        before do
          post :create, :format => 'json', :version => '0.1', :issue => {}
        end

        subject { response }
        its(:response_code) { should == 422 }
        its(:body) { should == {"name" => "can't be blank"}.to_json }
      end
    end
  end
end
