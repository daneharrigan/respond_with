module RespondWith
  module Helpers
    def respond_with(obj)
      RespondWith::Response.new({
        :object  => obj,
        :params  => params,
        :request => request,
        :app     => self
      }).render
    end
  end
end
