# mdJson 2.0 writer - geologic age

# History:
#   Stan Smith 2017-11-08 original script

require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module GeologicAge

               def self.build(hGeoAge)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.ageTimeScale hGeoAge[:ageTimeScale]
                     json.ageEstimate hGeoAge[:ageEstimate]
                     json.ageUncertainty hGeoAge[:ageUncertainty]
                     json.ageExplanation hGeoAge[:ageExplanation]
                     json.ageReference @Namespace.json_map(hGeoAge[:ageReferences], Citation)
                  end

               end # build
            end # GeologicAge

         end
      end
   end
end
