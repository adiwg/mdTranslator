# mdJson 2.0 writer - taxonomic System

# History:
#   Stan Smith 2017-03-17 original script

# TODO complete tests

require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module TaxonomicSystem

               def self.build(hTaxSystem)

                  Jbuilder.new do |json|
                     json.citation Citation.build(hTaxSystem[:citation]) unless hTaxSystem[:citation].empty?
                     json.modifications hTaxSystem[:modifications]
                  end

               end # build
            end # TaxonomicSystem

         end
      end
   end
end
