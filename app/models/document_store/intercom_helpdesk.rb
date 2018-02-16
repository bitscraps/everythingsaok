class DocumentStore < ActiveRecord::Base
  class IntercomHelpdesk < DocumentStore
    store_accessor :options,
                   :user
  end
end
