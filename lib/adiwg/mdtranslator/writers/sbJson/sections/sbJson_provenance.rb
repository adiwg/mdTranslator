# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-23 original script

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Provenance

               def self.build

                  hProvenance = {}
                  hProvenance[:annotation] = 'generated using ADIwg mdTranslator ' + ADIWG::Mdtranslator::VERSION

                  hProvenance

               end

            end

         end
      end
   end
end
