require File.dirname(__FILE__) + '/../spec_helper'

describe Question do

  it 'should belong to an answer' do
    assert_model_belongs_to Question, :answer
  end
end
