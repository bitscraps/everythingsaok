class Settings::DocumentStoresController < ApplicationController
  before_action :authenticate_user!

  def show
    @stores = DocumentStore.all
  end

  def update
    @store = DocumentStore.find(params[:id])
    puts @store.type
    if @store.type == 'DocumentStore::GithubWiki'
      DocumentationImporters::GithubWiki.new(@store.user, @store.project).import
    elsif @store.type == 'DocumentStore::GithubWiki'
      DocumentationImporters::IntercomHelpdesk.new(@store.user).import
    end

    redirect_to settings_document_stores_path
  end
end
