# mdJson 2.0 writer - releasability

# History:
#   Stan Smith 2017-03-17 original script

require 'jbuilder'
require_relative 'mdJson_responsibleParty'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Releasability

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hRelease)

                  Jbuilder.new do |json|
                     json.addressee @Namespace.json_map(hRelease[:addressee], ResponsibleParty)
                     json.statement hRelease[:statement]
                     json.disseminationConstraint hRelease[:disseminationConstraint] unless hRelease[:disseminationConstraint].empty?
                  end

               end # build
            end # Releasability

         end
      end
   end
end
