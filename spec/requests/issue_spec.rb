require 'rails_helper'

describe IssuesController, :type => :controller do
  describe '#index' do
    it 'should fetch index' do
      get :index, :format => 'json'
      expect(response.content_type).to eq "application/json"
      expect(json_response.count).to eq Issue.all.count
      expect(json_response.map { |issue| issue.fetch('title') }.uniq.count).to eq Issue.all.count
    end
  end
end
