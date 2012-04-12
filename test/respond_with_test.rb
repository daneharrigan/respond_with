require "test_helper"

class RespondWithTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def setup
    @item_hash = { name: "Item", type: "Sample", size: 42 }
  end

  def test_invalid_extention_renders_406
    get "/item.invalid"
    assert_equal 406, last_response.status
  end

  def test_invalid_accept_header_renders_406
    header "Accept", "invalid/type"
    get "/item"
    assert_equal 406, last_response.status
  end

  # JSON
  def test_request_with_json_extension
    get "/item.json"
    assert_equal @item_hash.to_json, last_response.body
  end

  def test_request_with_json_accept_header
    header "Accept", "application/json"
    get "/item"

    assert_equal @item_hash.to_json, last_response.body
  end

  def test_application_json_content_type
    get "/item.json"
    assert_equal "application/json;charset=utf-8", last_response.content_type
  end

  # XML
  def test_request_with_xml_extension
    get "/item.xml"
    xml = @item_hash.to_xml(root: "mock-item")

    assert_equal xml, last_response.body
  end

  def test_request_with_xml_accept_header
    header "Accept", "application/xml"
    get "/item"
    xml = @item_hash.to_xml(root: "mock-item")

    assert_equal xml, last_response.body
  end

  def test_application_xml_content_type
    get "/item.xml"
    assert_equal "application/xml;charset=utf-8", last_response.content_type
  end

  def app
    MyApp
  end
end

class MyApp < Sinatra::Base
  get "/item" do
    respond_with ItemSerializer.new(MockItem.new)
  end

  get "/item.:format" do
    respond_with ItemSerializer.new(MockItem.new)
  end
end
