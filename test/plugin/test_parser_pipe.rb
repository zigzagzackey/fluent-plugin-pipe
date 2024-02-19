require "helper"
require "fluent/plugin/parser_pipe.rb"

class PipeParserTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  test "parse" do
    # "message" => "1|2|3|4|5"というものを想定し，それをパースする
    d = create_driver(%[
      key_name message
      format pipe
    ])

    # パースするデータを設定
    d.instance.parse("1|2|3|4|5") { |time, record|
      assert_equal({"0" => "1", "1" => "2", "2" => "3", "3" => "4", "4" => "5"}, record)
    }

  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Parser.new(Fluent::Plugin::PipeParser).configure(conf)
  end
end
