# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module ContactPoint

               def self.build(intObj)
                  metadataInfo = intObj[:metadata][:metadataInfo]
                  metadataContacts = metadataInfo[:metadataContacts]

                  fn = "ToDo"
                  hasEmail = "ToDo"

                  Jbuilder.new do |json|
                     json.set!('@type', 'vcard:Contact')
                     json.set!('fn', fn)
                     json.set!('hasEmail', hasEmail)
                  end

               end
            end
         end
      end
   end
end
