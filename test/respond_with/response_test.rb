require "test_helper"

class RespondWith::ResponseTest < MiniTest::Unit::TestCase
  def setup
    @app     = nil
    @object  = Object.new
    @request = Sinatra::Request.new([])
    @params  = {}
  end

  def test_selected_reponse_is_json
    stub(@object).to_json { "{}" }
    stub(@request).accept { ["application/json", "*/*"] }

    assert_equal "applicaiton/json", response.content_type
  end

  def test_default_response_is_json
    stub(@object).to_json { "{}" }
    stub(@request).accept { ["*/*"] }

    assert_equal "applicaiton/json", response.content_type
  end

  private
    def response
      @response ||= RespondWith::Response.new({
        app:     @app,
        object:  @object,
        request: @request,
        params:  @params
      })
    end
end
