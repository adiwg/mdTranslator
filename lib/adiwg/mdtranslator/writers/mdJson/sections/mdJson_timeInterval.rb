# mdJson 2.0 writer - time interval

# History:
#   Stan Smith 2017-03-14 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module TimeInterval

               def self.build(hInterval)

                  Jbuilder.new do |json|
                     json.interval hInterval[:interval]
                     json.units hInterval[:units]
                  end

               end # build
            end # TimePeriod

         end
      end
   end
end
