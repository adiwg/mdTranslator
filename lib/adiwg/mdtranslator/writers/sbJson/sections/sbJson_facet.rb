# sbJson 1.0 writer facet

# History:
#  Stan Smith 2017-06-02 refactored for mdTranslator 2.0
#  Josh Bradley original script

require_relative 'sbJson_budget'
require_relative 'sbJson_project'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Facet

               def self.build(hMetadata)

                  aFacets = []

                  # budget facet
                  aFacets << Budget.build(hMetadata[:funding]) unless hMetadata[:funding].empty?

                  # project facet
                  aFacets << Project.build(hMetadata[:resourceInfo]) unless hMetadata[:resourceInfo].empty?

                  # citation facet

                  aFacets

               end

            end

         end
      end
   end
end
