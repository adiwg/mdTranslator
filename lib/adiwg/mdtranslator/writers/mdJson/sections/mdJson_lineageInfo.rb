# mdJson 2.0 writer - resource lineage

# History:
#   Stan Smith 2017-03-19 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_scope'
require_relative 'mdJson_citation'
require_relative 'mdJson_processStep'
require_relative 'mdJson_source'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module LineageInfo

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hLineage)

                  Jbuilder.new do |json|
                     json.statement hLineage[:statement]
                     json.scope Scope.build(hLineage[:resourceScope]) unless hLineage[:resourceScope].empty?
                     json.citation @Namespace.json_map(hLineage[:lineageCitation], Citation)
                     json.source @Namespace.json_map(hLineage[:dataSources], Source)
                     json.processStep @Namespace.json_map(hLineage[:processSteps], ProcessStep)
                  end

               end # build
            end # LineageInfo

         end
      end
   end
end
