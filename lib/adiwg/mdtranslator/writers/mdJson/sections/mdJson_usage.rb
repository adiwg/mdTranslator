# mdJson 2.0 writer - resource usage

# History:
#   Stan Smith 2017-03-18 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_temporalExtent'
require_relative 'mdJson_citation'
require_relative 'mdJson_responsibleParty'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Usage

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hUsage)

                  Jbuilder.new do |json|
                     json.specificUsage hUsage[:specificUsage]
                     json.temporalExtent @Namespace.json_map(hUsage[:temporalExtents],TemporalExtent)
                     json.userDeterminedLimitation hUsage[:userLimitation]
                     json.limitationResponse hUsage[:limitationResponses] unless hUsage[:limitationResponses].empty?
                     json.documentedIssue Citation.build(hUsage[:identifiedIssue]) unless hUsage[:identifiedIssue].empty?
                     json.additionalDocumentation @Namespace.json_map(hUsage[:additionalDocumentation], Citation)
                     json.userContactInfo @Namespace.json_map(hUsage[:userContacts], ResponsibleParty)
                  end

               end # build
            end # Usage

         end
      end
   end
end
