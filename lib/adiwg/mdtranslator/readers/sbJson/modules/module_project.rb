# unpack project facet
# Reader - ScienceBase JSON to internal data structure

# History:
#   Stan Smith 2016-06-27 original script

require 'adiwg/mdtranslator/writers/sbJson/sections/sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Readers
         module SbJson

            module Project

               @Namespace = ADIWG::Mdtranslator::Writers::SbJson

               def self.unpack(hFacet, hResourceInfo, hResponseObj)

                  # project status
                  if hFacet.has_key?('projectStatus')
                     unless hFacet['projectStatus'].nil? || ['projectStatus'] == ''
                        sbStatus = hFacet['projectStatus']
                        status = @Namespace::Codelists.codelist_iso_to_sb('iso_sb_progress', :sbCode => sbStatus)
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
