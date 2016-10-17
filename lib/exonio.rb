require 'bigdecimal'
require 'bigdecimal/newton'

require 'exonio/version'
require 'exonio/financial'
require 'exonio/statistical'
require 'exonio/helpers/irr_helper'

module Exonio
  extend Newton
  extend Financial
  extend Statistical
end
