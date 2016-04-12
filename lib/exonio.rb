require 'bigdecimal'
require 'bigdecimal/newton'

require 'exonio/version'
require 'exonio/financial'
require 'exonio/helpers'

include Newton

module Exonio
  extend Financial
end
