# unpack browse category
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-22 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_codelists'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module BrowseCategory

               def self.unpack(hSbJson, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hSbJson.has_key?('browseCategories')
                     hSbJson['browseCategories'].each do |category|
                        hResType = intMetadataClass.newResourceType
                        scope = Codelists.codelist_sb2adiwg('scope_sb2adiwg', category)
                        if scope.nil?
                           hResType[:type] = 'dataset'
                           hResType[:name] = category
                        else
                           hResType[:type] = scope
                        end
                        hResourceInfo[:resourceTypes] << hResType
                     end
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
