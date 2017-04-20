# mdJson 2.0 writer tests - identifier

# History:
#   Stan Smith 2017-03-13 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Identifier

               def self.build(hIdentifier)

                  Jbuilder.new do |json|
                     json.identifier hIdentifier[:identifier]
                     json.namespace hIdentifier[:namespace]
                     json.version hIdentifier[:version]
                     json.description hIdentifier[:description]
                     json.authority Citation.build(hIdentifier[:citation]) unless hIdentifier[:citation].empty?
                  end

               end# build
            end # Identifier

         end
      end
   end
end
