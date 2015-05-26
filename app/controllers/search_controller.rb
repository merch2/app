class SearchController < ApplicationController

  def search
    @query = params[:q]
    @condition = params[:condition]
    if @condition == 'all'
      @result = ThinkingSphinx.search @query
    else
      @result = @condition.singularize.capitalize.constantize.search @query
    end
  end

end
