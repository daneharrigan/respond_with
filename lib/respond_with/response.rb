module RespondWith
  class Response
    attr :app
    attr :params
    attr :object
    attr :request

    def initialize(options={})
      @app     = options[:app]
      @params  = options[:params]
      @object  = options[:object]
      @request = options[:request]
    end

    def render
      response_type = Negotiator.pick(request_types.join(", "), available_responses)

      if response_type.nil?
        @app.halt 406
      else
        @app.content_type(response_type)
        @object.to(response_type)
      end
    end

    def request_types
      format = params.delete "format"
      content_type = MIME::Types.type_for(format).first.to_s if format

      if content_type && request.accept.first != content_type
        request.accept.delete content_type
        request.accept.unshift content_type
      end

      return request.accept
    end

    private :request_types

    def available_responses
      responses = request_types.map do |request_type|
        if @object.responses.include?(request_type)
          [request_type, 1.0]
        end
      end.compact

      if request_types.include? "*/*"
        @object.responses.each do |response_type|
          response_rating = [response_type, 1.0]
          responses << response_rating unless responses.include? response_rating
        end
      end

      Hash[responses]
    end

    private :available_responses
  end
end
