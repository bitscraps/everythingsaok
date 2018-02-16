class DocumentationController < ApplicationController
  def index
    @documents = Document.all
  end
end