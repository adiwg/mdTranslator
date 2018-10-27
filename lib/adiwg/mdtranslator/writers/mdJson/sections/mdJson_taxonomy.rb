# mdJson 2.0 writer - taxonomy

# History:
#  Stan Smith 2018-10-26 refactor for mdJson schema 2.6.0
#  Stan Smith 2017-03-17 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_taxonomicSystem'
require_relative 'mdJson_citation'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_voucher'
require_relative 'mdJson_taxonomicClassification'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Taxonomy

               def self.build(hTaxonomy)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.taxonomicSystem @Namespace.json_map(hTaxonomy[:taxonSystem], TaxonomicSystem)
                     json.generalScope hTaxonomy[:generalScope]
                     json.identificationReference @Namespace.json_map(hTaxonomy[:idReferences], Citation)
                     json.observer @Namespace.json_map(hTaxonomy[:observers], ResponsibleParty)
                     json.identificationProcedure hTaxonomy[:idProcedure]
                     json.identificationCompleteness hTaxonomy[:idCompleteness]
                     json.voucher @Namespace.json_map(hTaxonomy[:vouchers], Voucher)
                     json.taxonomicClassification @Namespace.json_map(hTaxonomy[:taxonClasses], TaxonomicClassification)
                  end

               end # build
            end # Taxonomy

         end
      end
   end
end
