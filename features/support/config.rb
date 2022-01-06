require 'yaml'

#methods/helpers
require_relative 'helpers/wait_helper'
require_relative 'helpers/actions_helper'

#pages
require_relative 'pages/home_cvc'
require_relative 'pages/listing_cvc'

module Ng

  extend WaitHelper
  extend ActionsHelper
  extend HomeCVC
  extend ListingCVC
  
end