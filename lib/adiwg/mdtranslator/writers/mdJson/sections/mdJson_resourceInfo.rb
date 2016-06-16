require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_citation'
require_relative 'mdJson_timePeriod'
require_relative 'mdJson_responsibleParty'
require_relative 'mdJson_locale'
require_relative 'mdJson_format'
require_relative 'mdJson_keyword'
require_relative 'mdJson_resourceMaintenance'
require_relative 'mdJson_usage'
require_relative 'mdJson_graphicOverview'
require_relative 'mdJson_constraint'
require_relative 'mdJson_taxonomy'
require_relative 'mdJson_spatialreference'
require_relative 'mdJson_extent'
require_relative 'mdJson_gridInfo'
require_relative 'mdJson_coverageInfo'
require_relative 'mdJson_dataQuality'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module ResourceInfo
          extend MdJson::Base

          def self.build(_info)
            Jbuilder.new do |json|
              json.resourceType _info[:resourceType]
              json.citation Citation.build(_info[:citation])
              json.resourceTimePeriod TimePeriod.build(_info[:timePeriod]) # unless _info[:timePeriod].empty?
              json.pointOfContact json_map(_info[:pointsOfContact], ResponsibleParty)
              json.abstract _info[:abstract]
              json.shortAbstract _info[:shortAbstract]
              json.status _info[:status]
              json.hasMapLocation _info[:hasMapLocation?]
              json.hasDataAvailable _info[:hasDataAvailable?]
              json.language (_info[:resourceLanguages])
              json.characterSet (_info[:resourceCharacterSets])
              json.locale json_map(_info[:resourceLocales], Locale)
              json.purpose _info[:purpose]
              json.credit (_info[:credits])
              json.topicCategory (_info[:topicCategories])
              json.environmentDescription _info[:environmentDescription]
              json.resourceNativeFormat json_map(_info[:resourceFormats], Format)
              json.keyword json_map(_info[:descriptiveKeywords], Keyword)
              json.resourceMaintenance json_map(_info[:resourceMaint], ResourceMaintenance)
              json.resourceSpecificUsage json_map(_info[:resourceUses], Usage)
              json.graphicOverview json_map(_info[:graphicOverview], GraphicOverview)
              json.constraint Constraint.build(_info[:useConstraints], _info[:legalConstraints], _info[:securityConstraints])
              json.taxonomy Taxonomy.build(_info[:taxonomy])
              json.spatialReferenceSystem SpatialReference.build(_info[:spatialReferenceSystem])
              json.spatialResolution (_info[:spatialResolutions]) do |sr|
                json.equivalentScale sr[:equivalentScale]
                json.distance sr[:distance]
                json.uom sr[:distanceUOM]
              end
              json.extent json_map(_info[:extents], Extent)
              json.gridInfo json_map(_info[:gridInfo], GridInfo)
              json.coverageInfo json_map(_info[:coverageInfo], CoverageInfo)
              json.dataQualityInfo json_map(_info[:dataQualityInfo], DataQuality)
              json.supplementalInfo _info[:supplementalInfo]
            end
          end
        end
      end
    end
  end
end
