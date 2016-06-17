module ADIWG
  module Mdtranslator
    module Writers
      module SbJson
        module Facet
          def self.build(intObj)
            facets = []
            if intObj[:resourceType] == 'project'
              status = {
                completed: 'Completed',
                underDevelopment: 'Active',
                accepted: 'Approved',
                funded: 'Funded',
                onGoing: 'In Progress',
                proposed: 'Proposed'
              }
              facets << {
                className: 'gov.sciencebase.catalog.item.facet.ProjectFacet',
                projectStatus: status[:"#{intObj[:status]}"]
              }

            end

            facets
          end
        end
      end
    end
  end
end
