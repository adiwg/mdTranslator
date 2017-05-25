# mdJson 2.0 writer - citation

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Date

               def self.build(hDate)

                  Jbuilder.new do |json|
                     json.date(AdiwgDateTimeFun.stringFromDateObject(hDate))
                     json.dateType hDate[:dateType]
                  end

               end # build
            end # Date

         end
      end
   end
end
