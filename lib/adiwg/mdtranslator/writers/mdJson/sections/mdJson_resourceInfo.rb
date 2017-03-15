# mdJson 2.0 writer - resource information

# History:
#   Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

# TODO complete

require 'jbuilder'
require_relative 'mdJson_resourceType'
require_relative 'mdJson_citation'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_locale'
require_relative 'mdJson_timePeriod'
require_relative 'mdJson_spatialReference'
require_relative 'mdJson_spatialRepresentation'
# require_relative 'mdJson_format'
# require_relative 'mdJson_keyword'
# require_relative 'mdJson_resourceMaintenance'
# require_relative 'mdJson_usage'
# require_relative 'mdJson_graphicOverview'
# require_relative 'mdJson_constraint'
# require_relative 'mdJson_taxonomy'
# require_relative 'mdJson_extent'
# require_relative 'mdJson_gridInfo'
# require_relative 'mdJson_coverageInfo'
# require_relative 'mdJson_dataQuality'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module ResourceInfo

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hResInfo)
                  Jbuilder.new do |json|
                     json.resourceType @Namespace.json_map(hResInfo[:resourceTypes], ResourceType)
                     json.citation Citation.build(hResInfo[:citation])
                     json.abstract hResInfo[:abstract]
                     json.shortAbstract hResInfo[:shortAbstract]
                     json.purpose hResInfo[:purpose]
                     json.credit hResInfo[:credits] unless hResInfo[:credits].empty?
                     json.timePeriod TimePeriod.build(hResInfo[:timePeriod]) unless hResInfo[:timePeriod].empty?
                     json.status hResInfo[:status] unless hResInfo[:status].empty?
                     json.topicCategory hResInfo[:topicCategories]
                     json.pointOfContact @Namespace.json_map(hResInfo[:pointOfContacts], ResponsibleParty)
                     json.spatialReferenceSystem @Namespace.json_map(hResInfo[:spatialReferenceSystems], SpatialReference)
                     json.spatialRepresentationType hResInfo[:spatialRepresentationTypes] unless hResInfo[:spatialRepresentationTypes].empty?
                     json.spatialRepresentation @Namespace.json_map(hResInfo[:spatialRepresentations], SpatialRepresentation)


                     #   json.defaultResourceLocale Locale.build(hResInfo[:defaultResourceLocale])
                     #   json.hasMapLocation hResInfo[:hasMapLocation?]
                     #   json.hasDataAvailable hResInfo[:hasDataAvailable?]
                     #   json.language (hResInfo[:resourceLanguages])
                     #   json.characterSet (hResInfo[:resourceCharacterSets])
                     #   json.environmentDescription hResInfo[:environmentDescription]
                     #   json.resourceNativeFormat json_map(hResInfo[:resourceFormats], Format)
                     #   json.keyword json_map(hResInfo[:descriptiveKeywords], Keyword)
                     #   json.resourceMaintenance json_map(hResInfo[:resourceMaint], ResourceMaintenance)
                     #   json.resourceSpecificUsage json_map(hResInfo[:resourceUses], Usage)
                     #   json.graphicOverview json_map(hResInfo[:graphicOverview], GraphicOverview)
                     #   json.constraint Constraint.build(hResInfo[:useConstraints], hResInfo[:legalConstraints], hResInfo[:securityConstraints])
                     #   json.taxonomy Taxonomy.build(hResInfo[:taxonomy]) unless hResInfo[:taxonomy].empty?
                     #   json.spatialResolution (hResInfo[:spatialResolutions]) do |sr|
                     #     json.equivalentScale sr[:equivalentScale]
                     #     json.distance sr[:distance]
                     #     json.uom sr[:distanceUOM]
                     #   end
                     #   json.extent json_map(hResInfo[:extents], Extent)
                     #   json.gridInfo json_map(hResInfo[:gridInfo], GridInfo)
                     #   json.coverageInfo json_map(hResInfo[:coverageInfo], CoverageInfo)
                     #   json.dataQualityInfo json_map(hResInfo[:dataQualityInfo], DataQuality)
                     #   json.supplementalInfo hResInfo[:supplementalInfo]

                  end

               end # build
            end # ResourceInfo

         end
      end
   end
end
