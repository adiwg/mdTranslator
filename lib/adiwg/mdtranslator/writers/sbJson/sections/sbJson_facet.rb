# sbJson 1.0 writer facet

# History:
#  Stan Smith 2017-06-02 refactored for mdTranslator 2.0
#  Josh Bradley original script

require_relative 'sbJson_budget'
require_relative 'sbJson_project'
require_relative 'sbJson_publication'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Facet

               def self.build(hMetadata)

                  aFacets = []

                  # budget facet
                  unless hMetadata[:funding].empty?
                     hBudgetFacet = Budget.build(hMetadata[:funding])
                     aFacets << hBudgetFacet unless hBudgetFacet.empty?
                  end

                  # project facet
                  unless hMetadata[:resourceInfo].empty?
                     hProjectFacet = Project.build(hMetadata[:resourceInfo])
                     aFacets << hProjectFacet unless hProjectFacet.empty?
                  end

                  # publication facet (citation)
                  unless hMetadata[:resourceInfo].empty?
                     hPublicationFacet = Publication.build(hMetadata[:resourceInfo])
                     aFacets << hPublicationFacet unless hPublicationFacet.empty?
                  end

                  if aFacets.empty?
                     return nil
                  end

                  aFacets

               end

            end

         end
      end
   end
end
