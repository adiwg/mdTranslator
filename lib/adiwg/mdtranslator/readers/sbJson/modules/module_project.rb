# unpack project facet
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-27 original script

require_relative 'module_codelists'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Project

               def self.unpack(hFacet, hResourceInfo, hResponseObj)

                  # project status
                  if hFacet.has_key?('projectStatus')
                     unless hFacet['projectStatus'].nil? || ['projectStatus'] == ''
                        sbStatus = hFacet['projectStatus']
                        status = Codelists.codelist_sb2adiwg('progress_sb2adiwg', sbStatus)
                        status = status.nil? ? sbStatus : status
                        hResourceInfo[:status] << status
                     end
                  end

                  # short abstract
                  if hFacet.has_key?('parts')
                     hFacet['parts'].each do |hPart|
                        if hPart['type'] == 'Short Project Description'
                           hResourceInfo[:shortAbstract] = hPart['value']
                        end
                     end
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
