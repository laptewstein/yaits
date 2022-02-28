require 'rails_helper'

describe IssuesController, :type => :controller do
  describe '#index' do
    let(:priority) { IssuePriority.find(2) }
    let(:status) { IssueStatus.find(3) }
    let(:discipline) { Discipline.find(2) }
    let(:issue1) { Issue.new(title: "AAA Title", issue_priority_id: priority.id, issue_status_id: status.id, discipline_id: discipline.id) }
    let(:issue2) { Issue.new(title: "BBB Title", issue_priority_id: priority.id, issue_status_id: status.id, discipline_id: discipline.id) }

    before do
      issue1.save
      issue2.save
    end

    context 'index (all)' do
      it 'should fetch index' do
        get :index, :format => 'json'
        expect(response.content_type).to eq "application/json"
        expect(json_response.count).to eq Issue.all.count
        expect(json_response.map { |issue| issue.fetch('title') }.uniq.count).to eq Issue.all.count
      end
    end

    context 'filter index (subset)' do
      it 'should return records selectively, based on proper search params' do
        issue2.assignees << User.last

        get :index, format: 'json', params: {
          assignee: { 'id' => User.last.id.inspect },
          status:   { id: status.id },
          priority: { value: priority.value, type: 'exact' }
        }
        expect(json_response.count).to eq 1
        expect(json_response.first['id']).to eq issue2.id
        expect(json_response.first['title']).to eq issue2.title
      end

      it 'should not return records, based on faulty search params: unassigned user' do
        get :index, format: 'json', params: {
          assignee: { 'id' => User.last.id.inspect },
          status:   { id: status.id },
          priority: { value: priority.value, type: 'exact' }
        }
        expect(json_response).to eq []
      end

      # default behaviour:
      it 'should return records selectively, based on search params: priority down to highest importance' do
        get :index, format: 'json', params: { priority: { value: 1 } }
        expect(json_response).not_to be_empty
        priority_ids = json_response.map {|i| i['issue_priority_id'] }.uniq
        expect(IssuePriority.find(priority_ids).map(&:label)).to eq IssuePriority.where(value: (0..1).to_a).map &:label
      end

      it 'should return records selectively, based on search params: exact priority' do
        get :index, format: 'json', params: { priority: { value: 1, type: 'exact' } }
        expect(json_response.count).to be > 1
        priority_ids = json_response.map {|i| i['issue_priority_id'] }.uniq
        expect(priority_ids.count).to eq 1
      end
    end
  end
end
