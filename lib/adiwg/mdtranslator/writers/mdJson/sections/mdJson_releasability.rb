# mdJson 2.0 writer - releasability

# History:
#   Stan Smith 2017-03-17 original script

# TODO complete

require 'jbuilder'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_constraint'

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
                     json.disseminationConstraint @Namespace.json_map(hRelease[:disseminationConstraint], Constraint)
                  end

               end # build
            end # Releasability

         end
      end
   end
end
