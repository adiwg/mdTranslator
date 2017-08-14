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
                        hResource[:status].each do |status|
                           sbStatus = Codelists.codelist_adiwg2sb('progress_adiwg2sb', status)
                           unless sbStatus.nil?
                              hProject[:projectStatus] = sbStatus
                              break
                           end
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
