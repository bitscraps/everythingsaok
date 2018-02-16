class Settings::DocumentStoresController < ApplicationController
  def show
    @stores = DocumentStore.all
  end
end
