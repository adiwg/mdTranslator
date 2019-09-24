# mdJson 2.0 writer - nominal resolution

# History:
#  Stan Smith 2019-09-24 original script

require 'jbuilder'
require_relative 'mdJson_measure'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module NominalResolution

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hResolution)

                  Jbuilder.new do |json|
                     json.scanningResolution Measure.build(hResolution[:scanningResolution]) unless hResolution[:scanningResolution].empty?
                     json.groundResolution Measure.build(hResolution[:groundResolution]) unless hResolution[:groundResolution].empty?
                  end

               end # build
            end # NominalResolution

         end
      end
   end
end
