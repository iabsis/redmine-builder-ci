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
    @build = Builds.create(
      :project_id => params[:project_id],
      :status     => params[:status],
      :release     => params[:release],
      :commit     => params[:commit],
      :logs     => params[:logs],
    )
#    @build.safe_attributes = params[:build]

    if @build.save
      render_api_ok
    else
      render_api_errors "Bla"
    end
  end

  private

  def find_project
    # @project variable must be set before calling the authorize filter
    @project = Project.find(params[:project_id])
  end

end
