require 'bigdecimal'
require 'bigdecimal/newton'

require 'exonio/version'
require 'exonio/financial'
require 'exonio/helpers'

module Exonio
  extend Newton
  extend Financial
end
