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

                  publisher = responsibleParties&.detect { |party| party[:roleName] == 'publisher' } || distributorInfo&.first&.dig(:distributor)&.first&.dig(:contact)

                  name = publisher&.dig(:parties)&.first&.dig(:contactName)
                  contactType = publisher&.dig(:parties)&.first&.dig(:contactType)

                  contactType_to_dcatType = {
                     'organization' => 'org:Organization',
                     'individual' => 'org:Individual'
                  }

                  type = contactType_to_dcatType[contactType]

                  Jbuilder.new do |json|
                     json.set!('@type', type)
                     json.set!('name', name)
                  end
               end

            end
         end
      end
   end
end
