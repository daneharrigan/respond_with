require "sinatra/base"
require "respond_with"

class SampleApplication < Sinatra::Base
  get "/item.json" do
    @item = MockItem.new
    respond_with(ItemSerializer.new(@item))
  end
end
