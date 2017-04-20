# mdJson 2.0 writer - series

# History:
#   Stan Smith 2017-03-12 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Series

               def self.build(hSeries)

                  Jbuilder.new do |json|
                     json.seriesName hSeries[:seriesName]
                     json.seriesIssue hSeries[:seriesIssue]
                     json.issuePage hSeries[:issuePage]
                  end

               end # build
            end # Series

         end
      end
   end
end
