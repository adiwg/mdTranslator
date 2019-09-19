# mdJson 2.0 writer - online resource

# History:
#  Stan Smith 2019-09-18 add protocolRequest and applicationProfile
#  Stan Smith 2017-03-11 refactored for mdJson/mdTranslator 2.0
#  Josh Bradley original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module OnlineResource

               def self.build(hOlRes)

                  Jbuilder.new do |json|
                     json.uri hOlRes[:olResURI]
                     json.name hOlRes[:olResName]
                     json.description hOlRes[:olResDesc]
                     json.function hOlRes[:olResFunction]
                     json.applicationProfile hOlRes[:olResApplicationProfile]
                     json.protocol hOlRes[:olResProtocol]
                     json.protocolRequest hOlRes[:olResProtocolRequest]
                  end

               end # build
            end # OnlineResource

         end
      end
   end
end
