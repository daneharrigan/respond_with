module RespondWith
  class Response
    attr :app
    attr :params
    attr :object
    attr :request

    def initialize(options={})
      @app      = options[:app]
      @params   = options[:params]
      @object   = options[:object]
      @request  = options[:request]
    end

    def render
      response_rating    = @object.responses.map { |response| [response, 1.0] }
      available_respones = Hash[response_rating]
      response_type = Negotiator.pick(request_types.join(", "), available_respones)

      if response_type.nil?
        @app.halt 406
      else
        @app.content_type(response_type)
        @object.to(response_type)
      end
    end

    def request_types
      format = params.delete "format"
      content_type = case format
        when "json" then "application/json"
        when "xml"  then "application/xml"
      end

      unless request.accept.first == content_type
        request.accept.delete content_type
        request.accept.unshift content_type
      end

      return request.accept
    end

    private :request_types
  end
end
