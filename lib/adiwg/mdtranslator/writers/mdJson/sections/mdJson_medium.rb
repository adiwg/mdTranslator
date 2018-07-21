# mdJson 2.0 writer - medium

# History:
#  Stan Smith 2017-03-20 original script

require 'jbuilder'
require_relative 'mdJson_citation'
require_relative 'mdJson_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Medium

               @Namespace = ADIWG::Mdtranslator::Writers::MdJson

               def self.build(hMedium)

                  Jbuilder.new do |json|
                     json.mediumSpecification Citation.build(hMedium[:mediumSpecification]) unless hMedium[:mediumSpecification].empty?
                     json.density hMedium[:density]
                     json.units hMedium[:units]
                     json.numberOfVolumes hMedium[:numberOfVolumes]
                     json.mediumFormat hMedium[:mediumFormat] unless hMedium[:mediumFormat].empty?
                     json.note hMedium[:note]
                     json.identifier Identifier.build(hMedium[:identifier]) unless hMedium[:identifier].empty?
                  end

               end # build
            end # Medium
            
         end
      end
   end
end
