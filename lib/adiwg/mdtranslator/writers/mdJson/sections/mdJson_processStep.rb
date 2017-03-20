# mdJson 2.0 writer - process step

# History:
#   Stan Smith 2017-03-19 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete

require 'jbuilder'
require_relative 'mdJson_timePeriod'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_citation'
require_relative 'mdJson_scope'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ProcessStep

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hStep)

                  Jbuilder.new do |json|
                     json.stepId hStep[:stepId]
                     json.description hStep[:description]
                     json.rationale hStep[:rationale]
                     json.timePeriod TimePeriod.build(hStep[:timePeriod]) unless hStep[:timePeriod].empty?
                     json.processor @Namespace.json_map(hStep[:processors], ResponsibleParty)
                     json.reference @Namespace.json_map(hStep[:references], Citation)
                     json.scope Scope.build(hStep[:scope]) unless hStep[:scope].empty?
                  end

               end # build
            end # ProcessStep

         end
      end
   end
end
