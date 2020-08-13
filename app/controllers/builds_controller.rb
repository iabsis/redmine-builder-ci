class BuildsController < ApplicationController
  unloadable

  before_filter :find_project, :authorize, :only => [:view, :index]
  before_filter :find_project, :authorize, :only => :new

  accept_api_auth :new

  def index
    @project = Project.find(params[:project_id])
    @builds = Builds.where(project_id: @project.id).reorder("id DESC").limit(25)
  end

  def view
    @project = Project.find(params[:project_id])
    @build = Builds.find(params[:id])
  end

  def new

    ## Permit to send params with project identifier instead of its id.

    build = Builds.create(
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

    if build.save
      render_api_ok
    else
      render_api_errors "Invalid data"
    end
  end

  private

  def find_project
    # @project variable must be set before calling the authorize filter
    params[:project_id] ||= Project.find_by(identifier: params[:project]).id
    @project = Project.find(params[:project_id])
  end

end
