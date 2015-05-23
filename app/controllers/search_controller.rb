class SearchController < ApplicationController

  def search
    @query = params[:q]
    @condition = params[:condition]
    if @condition == 'all'
      @result = ThinkingSphinx.search @query
    elsif @condition == 'questions'
      @result = Question.search @query
    else
      @result = Question.search load_conditions
    end
  end

  private
  def load_conditions
    { conditions: { @condition => @query } }
  end
end
