# mdJson 2.0 writer - dimension

# History:
#   Stan Smith 2017-03-14 original script

require 'jbuilder'
require_relative 'mdJson_measure'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Dimension

               def self.build(hDimension)

                  Jbuilder.new do |json|
                     json.dimensionType hDimension[:dimensionType]
                     json.dimensionSize hDimension[:dimensionSize]
                     json.resolution Measure.build(hDimension[:resolution]) unless hDimension[:resolution].empty?
                     json.dimensionTitle hDimension[:dimensionTitle]
                     json.dimensionDescription hDimension[:dimensionDescription]
                  end

               end # build
            end # Dimension

         end
      end
   end
end
