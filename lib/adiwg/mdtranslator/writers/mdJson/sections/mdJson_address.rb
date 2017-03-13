# mdJson 2.0 writer - address

# History:
#   Stan Smith 2017-03-12 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Address

               def self.build(hAddress)

                  Jbuilder.new do |json|
                     json.addressType hAddress[:addressTypes]
                     json.description hAddress[:description]
                     json.deliveryPoint hAddress[:deliveryPoints] unless hAddress[:deliveryPoints].empty?
                     json.city hAddress[:city]
                     json.administrativeArea hAddress[:adminArea]
                     json.postalCode hAddress[:postalCode]
                     json.country hAddress[:country]
                  end

               end # build
            end # Address

         end
      end
   end
end
