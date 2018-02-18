class DocumentationController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end
end