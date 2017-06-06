# sbJson 1.0 writer project

# History:
#  Stan Smith 2017-06-02 original script

require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Project

               def self.build(hResource)

                  hProject = {}

                  hResource[:resourceTypes].each do |hResourceType|
                     if hResourceType[:type] == 'project'
                        hProject[:className] = 'gov.sciencebase.catalog.item.facet.ProjectFacet'
                        # TODO treat as a array take first
                        unless hResource[:status].empty?
                           status = hResource[:status][0]
                           sbStatus = Codelists.codelist_iso_to_sb('iso_sb_progress', :isoCode => status)
                           hProject[:projectStatus] = sbStatus
                        end
                        unless hResource[:shortAbstract].nil?
                           hProject[:parts] = [
                              {
                                 type: 'Short Project Description',
                                 value: hResource[:shortAbstract]
                              }
                           ]
                        end
                     end
                  end

                  hProject

               end

            end

         end
      end
   end
end
