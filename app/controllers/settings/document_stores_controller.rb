class Settings::DocumentStoresController < ApplicationController
  before_action :authenticate_user!

  def show
    @stores = DocumentStore.all
  end

  def update
    @store = DocumentStore.find(params[:id])
    puts @store.type
    if @store.type == 'DocumentStore::GithubWiki'
      DocumentationImporters::GithubWiki.new(@store).import
    elsif @store.type == 'DocumentStore::IntercomHelpdesk'
      DocumentationImporters::Intercom.new(@store).import
    end

    redirect_to settings_document_stores_path
  end
end
