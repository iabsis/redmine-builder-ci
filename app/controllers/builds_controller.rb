class BuildsController < ApplicationController
  unloadable

  before_action :find_project, :authorize, :only => [:view, :index]
  before_action :find_project, :authorize, :only => :new

  accept_api_auth :new, :update

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
      render json: build.id
    else
      render_api_errors "Invalid data"
    end
  end

  def update

    @build = Builds.find(params[:id])
    @build.update(
      :status     => params[:status],
      :release     => params[:release],
      :commit     => params[:commit],
      :logs     => params[:logs],
      :target   => params[:target],
      :builder  => params[:builder],
      :started_at => params[:started_at],
      :finished_at => params[:finished_at]
    )

    render json: @build.id

  end

  def build_params
    params.require(:build).permit(:project_id, :status, :release)
  end

  def all
    @builds = Builds.find_each(batch_size: 5000)
  end

  private  

  def find_project
    # @project variable must be set before calling the authorize filter
    params[:project_id] ||= Project.find_by(identifier: params[:project]).id
    @project = Project.find(params[:project_id])
  end

end
