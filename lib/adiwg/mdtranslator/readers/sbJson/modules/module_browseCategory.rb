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

               def self.unpack(hJson, aResourceTypes, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  if hJson.has_key?('browseCategories')
                     hJson['browseCategories'].each do |category|
                        hResType = intMetadataClass.newResourceType
                        scope = Codelists.codelist_sb2adiwg('scope_sb2adiwg', category)
                        if scope.nil?
                           hResType[:type] = 'dataset'
                           hResType[:name] = category
                        else
                           hResType[:type] = scope
                        end
                        aResourceTypes << hResType
                     end
                  end

                  return aResourceTypes

               end

            end

         end
      end
   end
end
