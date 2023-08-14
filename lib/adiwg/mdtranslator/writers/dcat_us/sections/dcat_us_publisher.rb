# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Publisher

               def self.build(intObj)
                  metadata = intObj.dig(:metadata)
                  responsibleParties = metadata&.dig(:resourceInfo, :citation, :responsibleParties)
                  distributorInfo = metadata&.dig(:distributorInfo)

                  publisher = responsibleParties&.detect { |party| party[:roleName] == 'publisher' }

                  if publisher.nil? || publisher.dig(:parties)&.first&.dig(:contactType) != 'organization'
                     distributor = distributorInfo&.first&.dig(:distributor)&.first
                     if distributor&.dig(:contact)&.dig(:contactType) == 'organization'
                        publisher = distributor&.dig(:contact)
                     end
                  end

                  name = publisher&.dig(:parties)&.first&.dig(:contactName)

                  Jbuilder.new do |json|
                     json.set!('@type', 'org:Organization')
                     json.set!('name', name)
                  end
               end

            end
         end
      end
   end
end
