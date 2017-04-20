# mdJson 2.0 writer - format

# History:
#   Stan Smith 2017-03-18 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module Format

               def self.build(hFormat)

                  Jbuilder.new do |json|
                     json.formatSpecification Citation.build(hFormat[:formatSpecification]) unless hFormat[:formatSpecification].empty?
                     json.amendmentNumber hFormat[:amendmentNumber]
                     json.compressionMethod hFormat[:compressionMethod]
                  end

               end # build
            end # Format

         end
      end
   end
end
