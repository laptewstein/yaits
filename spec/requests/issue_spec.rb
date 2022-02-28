require 'rails_helper'

describe IssuesController, :type => :controller do
  describe '#index' do
    let(:priority) { IssuePriority.find(2) }
    let(:status) { IssueStatus.find(3) }
    let(:discipline) { Discipline.find(2) }
    let(:issue1) { Issue.new(title: "AAA Title", issue_priority_id: priority.id, issue_status_id: status.id, discipline_id: discipline.id) }
    let(:issue2) { Issue.new(title: "BBB Title", issue_priority_id: priority.id, issue_status_id: status.id, discipline_id: discipline.id) }

    it 'should fetch index' do
      get :index, :format => 'json'
      expect(response.content_type).to eq "application/json"
      expect(json_response.count).to eq Issue.all.count
      expect(json_response.map { |issue| issue.fetch('title') }.uniq.count).to eq Issue.all.count
    end

    it 'should return records selectively based on search params (with discipline)' do
      issue1.save
      issue2.assignees << User.last
      issue2.save

      get :index, format: 'json', params: {
        assignee: { 'id' => User.last.id.inspect },
        status:   { id: status.id },
        priority: { value: priority.value, type: 'exact' }
      }
      expect(json_response.count).to eq 1
      expect(json_response.first['id']).to eq issue2.id
      expect(json_response.first['title']).to eq issue2.title
    end

    it 'should return records selectively based on search params (user is unassigned)' do
      issue1.save
      issue2.save

      get :index, format: 'json', params: {
        assignee: { 'id' => User.last.id.inspect },
        status:   { id: status.id },
        priority: { value: priority.value, type: 'exact' }
      }
      expect(json_response.count).to eq 0
    end

    it 'should return records selectively based on search params (only on priority)' do
      issue1.save
      issue2.save

      # default behaviour: requested priority  and below (down to highest importance)
      get :index, format: 'json', params: { priority: { value: 1 } }

      expect(json_response).not_to be_empty
      priority_ids = json_response.map {|i| i['issue_priority_id'] }.uniq
      expect(IssuePriority.find(priority_ids).map(&:label)).to eq IssuePriority.where(value: (0..1).to_a).map &:label
    end
  end
end
