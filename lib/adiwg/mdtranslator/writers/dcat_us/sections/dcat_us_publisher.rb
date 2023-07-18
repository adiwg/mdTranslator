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
                  metadataInfo = intObj[:metadata][:metadataInfo]
                  metadataContacts = metadataInfo[:metadataContacts]

                  name = "ToDo"
                  subOrganizationOf = "ToDo"

                  Jbuilder.new do |json|
                     json.set!('@type', 'org:Organization')
                     json.set!('name', name)
                     json.set!('subOrganizationOf', subOrganizationOf)
                  end

               end
            end
         end
      end
   end
end
