require "bundler/setup"
require "minitest/autorun"
require "rack/test"

require "respond_with"
require "serialize"

require "support/mock_item"
require "support/item_serializer"
require "support/sample_application"

ENV["RACK_ENV"] = "test"
