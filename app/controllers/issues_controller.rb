class IssuesController < ApplicationController
  before_action :set_issue, only: %w(show edit update destroy)

  # GET /issues or /issues.json
  def index
    @issues = filter_params.empty? ? Issue.all : filtered_issues
    respond_to do |format|
      format.html { @issues }
      format.json { render json: @issues, status: :ok }
    end
  end

  # GET /issues/1 or /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues or /issues.json
  def create
    @issue = Issue.new(issue_params.except(:assignee_ids))
    new_user_ids = issue_params
      .fetch(:assignee_ids, [])
      .reject(&:empty?)
      .map(&:to_i)
    @issue.assignees << User.find(new_user_ids)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to issue_url(@issue), notice: "Issue was successfully created." }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1 or /issues/1.json
  def update
    new_user_ids = issue_params
      .fetch(:assignee_ids, [])
      .reject(&:empty?)
      .map(&:to_i)

    remaining_user_ids = @issue.assignees.map do |assignee|
      unless new_user_ids.include?(assignee.id)
        # remove redundant assignees
        @issue.assignees.delete(assignee)
        next
      end
      assignee.id
    end
    @issue.assignees << User.find(new_user_ids - remaining_user_ids)

    respond_to do |format|
      if @issue.update(issue_params.except(:assignee_ids))
        format.html { redirect_to issue_url(@issue), notice: "Issue ##{@issue.id} was successfully updated." }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1 or /issues/1.json
  def destroy
    issue_id, title = [ @issue.id, @issue.title ]
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url, notice: "(#{issue_id}) #{title} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # required params for update / create
    def issue_params
      params
        .require(:issue)
        .permit(:title, :description, :issue_status_id, :issue_priority_id, :discipline_id, :assignee_ids => [])
    end

    # optional params for sorting / filtering
    def filter_params
      params
        .permit(:assignee => [:id], discipline: [:id], :status => [:id], priority: [ :value, :type ])
    end

    def filtered_issues
      filter(Issue.all, filter_params.keys)
    end

    # recursively percolate/select based on filtering params
    def filter(queryset, filter_types)
      selector = filter_types.pop

      return queryset unless selector
      filtered_queryset = queryset.select do |issue|
        case selector
        when 'assignee'
          id = filter_params[selector][:id].to_i
          issue.assignees.map(&:id).include?(id)
        when 'status'
          unless issue.status.nil?
            id = filter_params[selector][:id].to_i
            issue.status.id == id
          end
        when 'discipline'
          unless issue.discipline.nil?
            id = filter_params[selector][:id].to_i
            issue.discipline.id == id
          end
        when 'priority'
          unless issue.priority.nil?
            value = filter_params[selector][:value].to_i
            if filter_params.dig(selector, :type) == 'exact'
              issue.priority.value == value
            else
              issue.priority.value < value.succ
            end
          end
        end
      end
      filter(filtered_queryset, filter_types)
    end
end
