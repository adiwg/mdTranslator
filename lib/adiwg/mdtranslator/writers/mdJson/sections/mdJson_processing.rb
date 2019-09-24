# mdJson 2.0 writer - processing

# History:
#  Stan Smith 2019-09-24 original script

require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_citation'
require_relative 'mdJson_algorithm'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Processing

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hProcess)

                  Jbuilder.new do |json|
                     json.identifier Identifier.build(hProcess[:identifier]) unless hProcess[:identifier].empty?
                     json.softwareReference @Namespace.json_map(hProcess[:softwareReferences], Citation)
                     json.procedureDescription hProcess[:procedureDescription]
                     json.documentation @Namespace.json_map(hProcess[:documentation], Citation)
                     json.runtimeParameters hProcess[:runtimeParameters]
                     json.algorithm @Namespace.json_map(hProcess[:algorithms], Algorithm)
                  end

               end # build
            end # Processing

         end
      end
   end
end
