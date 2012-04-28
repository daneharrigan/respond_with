require "sinatra/base"
require "negotiator"
require "mime/types"
require "serialize"
require "respond_with/version"
require "respond_with/response"
require "respond_with/helpers"

Sinatra::Base.helpers RespondWith::Helpers
