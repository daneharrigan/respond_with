module RespondWith
  module Helpers
    def respond_with(obj, opts={})
      RespondWith::Response.new({
        :object  => obj,
        :params  => params,
        :request => request,
        :options => opts,
        :app     => self
      }).render
    end
  end
end
