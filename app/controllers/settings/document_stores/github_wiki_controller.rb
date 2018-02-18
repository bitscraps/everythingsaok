module Settings
  module DocumentStores
    class GithubWikiController < ApplicationController
      before_action :authenticate_user!
      
      def new
        @store = DocumentStore::GithubWiki.new()
      end

      def create
        @store = DocumentStore::GithubWiki.new(store_params)
        @store.save!
        redirect_to settings_document_stores_path
      end

      private

      def store_params
        params.require(:document_store_github_wiki).permit(:name, :user, :project)
      end
    end
  end
end
