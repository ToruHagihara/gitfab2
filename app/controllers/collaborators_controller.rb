class CollaboratorsController < ApplicationController
  before_action :load_owner
  before_action :load_project
  before_action :load_collaborator, only: :create
  before_action :build_collaboration, only: :create

  def index
  end

  def create
    if @collaboration.save
      render :create
    else
      render "errors/failed", status: 400
    end
  end

  private
  def load_owner
    @owner = User.find(params[:owner_name]) || Group.find(params[:owner_name])
  end

  def load_project
    @project = @owner.projects.find params[:project_id]
  end

  def load_collaborator
    collaborator_id = params[:collaborator_name]
    @collaborator = User.find(collaborator_id) || Group.find(collaborator_id)
  end

  def build_collaboration
    @collaboration = @collaborator.collaborations.build project_id: @project.id
  end
end
