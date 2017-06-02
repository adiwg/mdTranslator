# sbJson 1.0 writer facet

# History:
#  Stan Smith 2017-06-02 refactored for mdTranslator 2.0
#  Josh Bradley original script

require_relative 'sbJson_budget'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Facet

               def self.build(hMetadata)

                  aFunding = hMetadata[:funding]

                  aFacets = []

                  # budget facet
                  aFacets << Budget.build(aFunding) unless aFunding.empty?

                  # project facet

                  aFacets

               end

            end

         end
      end
   end
end
