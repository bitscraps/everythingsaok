class DocumentStore < ActiveRecord::Base
  class GithubWiki < DocumentStore
    store_accessor :options,
                   :user,
                   :project,
                   :oauth_token
  end
end
