class QuestionsController < ApplicationController 

def index 
  @title = "Questions"
@questions = Question.find(:all) 
respond_to do |format| 
format.html
format.js { render :js => @questions.to_json }
format.xml { render :xml => @questions.to_xml } 
format.yaml { render :yaml => @questions.to_yaml } 
end 
end 

end