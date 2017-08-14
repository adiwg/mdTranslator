# unpack citation facet
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-25 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_codelists'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Publication

               def self.unpack(hFacet, hResourceInfo, hCitation, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # set resource type
                  if hFacet.has_key?('citationType')
                     unless hFacet['citationType'].nil? || hFacet['citationType'] == ''
                        hResType = intMetadataClass.newResourceType
                        sbType = hFacet['citationType']
                        adiwgType = Codelists.codelist_sb2adiwg('scope_sb2adiwg', sbType)
                        type = adiwgType.nil? ? sbType : adiwgType
                        hResType[:type] = type
                        hResType[:name] = sbType
                        hResourceInfo[:resourceTypes] << hResType
                     end
                  end

                  # set citation
                  hSeries = intMetadataClass.newSeries
                  if hFacet.has_key?('note')
                     unless hFacet['note'].nil? || hFacet['note'] == ''
                        i = hCitation[:otherDetails].length
                        hCitation[:otherDetails][i] = hFacet['note']
                     end
                  end
                  if hFacet.has_key?('journal')
                     unless hFacet['journal'].nil? || hFacet['journal'] == ''
                        hSeries[:seriesName] = hFacet['journal']
                     end
                  end
                  if hFacet.has_key?('edition')
                     unless hFacet['edition'].nil? || hFacet['edition'] == ''
                        hSeries[:seriesIssue] = hFacet['edition']
                     end
                  end
                  unless hSeries.empty?
                     hCitation[:series] = hSeries
                  end

                  # set default language
                  if hFacet.has_key?('language')
                     unless hFacet['language'].nil? || hFacet['language'] == ''
                        hLocale = intMetadataClass.newLocale
                        hLocale[:languageCode] = hFacet['language']
                        hResourceInfo[:defaultResourceLocale] = hLocale
                     end
                  end

                  return hResourceInfo, hCitation

               end

            end

         end
      end
   end
end
