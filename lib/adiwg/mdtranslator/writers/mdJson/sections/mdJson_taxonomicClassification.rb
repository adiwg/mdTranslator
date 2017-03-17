# mdJson 2.0 writer - taxonomic classification

# History:
#   Stan Smith 2017-03-17 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete tests

require 'jbuilder'
require_relative 'mdJson_taxonomicClassification'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module TaxonomicClassification

               def self.build(hTaxon)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.taxonomicSystemId hTaxon[:taxonId]
                     json.taxonomicRank hTaxon[:taxonRank]
                     json.latinName hTaxon[:taxonValue]
                     json.commonName hTaxon[:commonNames] unless hTaxon[:commonNames].empty?
                     json.subClassification @Namespace.json_map(hTaxon[:subClasses], TaxonomicClassification)
                  end

               end # build
            end # TaxonomicClassification

         end
      end
   end
end
