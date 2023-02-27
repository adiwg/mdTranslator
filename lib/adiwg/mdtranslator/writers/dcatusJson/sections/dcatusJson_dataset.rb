
require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module DcatusJson

            module Dataset

               @Namespace = ADIWG::Mdtranslator::Writers::DcatusJson

               def self.build(hMetadata)
                  resourceInfo = hMetadata[:resourceInfo]
                  hCitation = resourceInfo[:citation]

                  Jbuilder.new do |json|
                     json.title hCitation[:title]
                     json.description resourceInfo[:abstract]
                  end
               end # build
            end # Dataset

         end
      end
   end
end
