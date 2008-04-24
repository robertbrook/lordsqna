require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/model_spec_helper'

describe Question do

  it 'should belong to an answer' do
    assert_model_belongs_to Question, :answer
  end

end

describe Question, 'when loading' do

  include ModelSpecHelper

  it 'should ignore unneeded attribute' do
    lambda { Question.create_from(:title => 'title') }.should_not raise_error
  end

  it 'should load member' do
    assert_loads_attribute Question, :member
  end

  it 'should load uin' do
    assert_loads_attribute Question, :uin
  end

  it 'should load text' do
    assert_loads_attribute Question, :text
  end

end
