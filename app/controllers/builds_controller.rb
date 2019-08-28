class BuildsController < ApplicationController
  default_search_scope :builds
  before_filter :find_project, :authorize, :only => :index


  def index
    @project = Project.find(params[:project_id])
    @builds = Builds.where(project_id: @project.id)
  end

  def view
    @project = Project.find(params[:project_id])
    @build = Builds.find(params[:id])
  end

  def new

    ## Permit to send params with project identifier instead of its id.
    params[:project_id] ||= Project.find_by(identifier: params[:project]).id

    @build = Builds.create(
      :project_id => params[:project_id],
      :status     => params[:status],
      :release     => params[:release],
      :commit     => params[:commit],
      :logs     => params[:logs],
      :target   => params[:target],
      :builder  => params[:builder],
      :started_at => params[:started_at],
      :finished_at => params[:finished_at]
    )

    if @build.save
      render_api_ok
    else
      render_api_errors "Invalid data"
    end
  end

  private

  def find_project
    # @project variable must be set before calling the authorize filter
    @project = Project.find(params[:project_id])
  end

end
