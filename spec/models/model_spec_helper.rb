module ModelSpecHelper

  def assert_loads_attribute model, symbol
    value = mock(symbol.to_s)
    group = model.create_from(symbol => value)
    group.send(symbol).should == value
  end

end
