# RespondWith

The `respond_with` gem is an extension of Sinatra. It is intended to
make API responses dead simple.

## Installation

`respond_with` relies on the serialize gem which is still in development
so you'll need to install that from git.

Add these lines to your application's Gemfile:

    gem 'respond_with', :git => 'git://github.com/daneharrigan/respond_with.git'
    gem 'serialize',    :git => 'git://github.com/daneharrigan/serialize.git'

And then execute:

    $ bundle

## Usage
    require "sinatra"
    require "respond_with"

    # in a sinatra app
    get "/resources/:id.?:format?" do
      @resource = Resource.find(params[:id])
      respond_with ResourceSerializer.new(@resource)
    end

Notice we're using a `ResourceSerializer`. This is built with the
[serialize][1] gem.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[1]: https://github.com/heroku/serialize
