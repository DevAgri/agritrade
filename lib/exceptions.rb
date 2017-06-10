module Exceptions
  InvalidProvider = Class.new(StandardError)

  module Provider
    InvalidAccessToken = Class.new(InvalidCall)
    InvalidResponse = Class.new(InvalidCall)
  end
end
