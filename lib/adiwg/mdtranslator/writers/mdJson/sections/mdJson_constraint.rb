# mdJson 2.0 writer - constraint

# History:
#   Stan Smith 2017-03-17 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_scope'
require_relative 'mdJson_graphicOverview'
require_relative 'mdJson_citation'
require_relative 'mdJson_releasability'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_legalConstraint'
require_relative 'mdJson_securityConstraint'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Constraint

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hConstraint)

                  Jbuilder.new do |json|
                     json.type hConstraint[:type]
                     json.useLimitation hConstraint[:useLimitation] unless hConstraint[:useLimitation].empty?
                     json.scope Scope.build(hConstraint[:scope]) unless hConstraint[:scope].empty?
                     json.graphic @Namespace.json_map(hConstraint[:graphic], GraphicOverview)
                     json.reference @Namespace.json_map(hConstraint[:reference], Citation)
                     json.releasability Releasability.build(hConstraint[:releasability]) unless hConstraint[:releasability].empty?
                     json.responsibleParty @Namespace.json_map(hConstraint[:responsibleParty], ResponsibleParty)
                     json.legal LegalConstraint.build(hConstraint[:legalConstraint]) unless hConstraint[:legalConstraint].empty?
                     json.security SecurityConstraint.build(hConstraint[:securityConstraint]) unless hConstraint[:securityConstraint].empty?
                  end

               end # build
            end # Constraint

         end
      end
   end
end
