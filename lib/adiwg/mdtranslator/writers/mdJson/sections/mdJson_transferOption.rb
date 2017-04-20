# mdJson 2.0 writer - transfer option

# History:
#   Stan Smith 2017-03-20 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_onlineResource'
require_relative 'mdJson_medium'
require_relative 'mdJson_duration'
require_relative 'mdJson_format'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module TransferOption

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hOption)

                  Jbuilder.new do |json|
                     json.unitsOfDistribution hOption[:unitsOfDistribution]
                     json.transferSize hOption[:transferSize]
                     json.onlineOption @Namespace.json_map(hOption[:onlineOptions], OnlineResource)
                     json.offlineOption @Namespace.json_map(hOption[:offlineOptions], Medium)
                     json.transferFrequency Duration.build(hOption[:transferFrequency]) unless hOption[:transferFrequency].empty?
                     json.distributionFormat @Namespace.json_map(hOption[:distributionFormats], Format)
                  end

               end # build
            end # TransferOption

         end
      end
   end
end
