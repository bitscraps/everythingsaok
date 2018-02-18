module Settings
  module DocumentStores
    class IntercomHelpdeskController < ApplicationController
      before_action :authenticate_user!
      
      def new
        @store = DocumentStore::IntercomHelpdesk.new()
      end

      def create
        @store = DocumentStore::IntercomHelpdesk.new(store_params)
        @store.save!
        redirect_to settings_document_stores_path
      end

      private

      def store_params
        params.require(:document_store_intercom_helpdesk).permit(:name, :user)
      end
    end
  end
end
