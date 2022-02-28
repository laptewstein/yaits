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
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    def issue_params
      params
        .require(:issue)
        .permit(:title, :description, :issue_status_id, :issue_priority_id, :discipline_id, :assignee_ids => [])
    end

    #optional params
    def filter_params
      params.fetch(:sort, {}).permit(:type, :criteria, :value)
    end

    def filtered_issues
      return Issue.all unless filter_params[:type] == 'assignee'
      filter(Issue.all, filter_params[:type])
    end

    def filter(queryset, filter_type)
      queryset.select do |issue|
        case filter_type
        when 'assignee'
          value = filter_params[:value].to_i
          issue.assignees.map(&:id).include?(value)
        end
      end
    end
end
