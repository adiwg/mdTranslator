# mdJson 2.0 writer - domain item

# History:
#   Stan Smith 2017-03-19 original script

require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module DomainItem

               def self.build(hItem)

                  Jbuilder.new do |json|
                     json.name hItem[:itemName]
                     json.value hItem[:itemValue]
                     json.definition hItem[:itemDefinition]
                     unless hItem[:itemReference].empty?
                        json.reference Citation.build(hItem[:itemReference])
                     end
                  end

               end # build
            end # DomainItem

         end
      end
   end
end
