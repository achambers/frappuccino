require 'test_helper'

require 'frappuccino'

class Button
  def push
    emit(:pushed)
  end
end

describe "MVP interaction" do
  it "can subscribe to an event stream" do
    button = Button.new
    stream = Frappuccino::Stream.new(button)

    counter = stream
              .map {|event| event == :pushed ? 1 : 0 }
              .inject(0) {|sum, n| sum + n }

    assert_equal 0, counter.to_i

    button.push
    button.push
    button.push

    assert_equal 3, counter.to_i

    button.push

    assert_equal 4, counter.to_i
  end
end
