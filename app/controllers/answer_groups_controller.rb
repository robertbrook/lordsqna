class AnswerGroupsController < ApplicationController

  def index
    @answer_groups = AnswerGroup.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answer_groups }
    end
  end

  def show
    @answer_group = AnswerGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer_group }
    end
  end
end
