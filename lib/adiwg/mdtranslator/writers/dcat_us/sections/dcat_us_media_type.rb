require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module MediaType

               def self.build(transfer)
                  transfer.dig(:distributionFormats)&.find { |format| format.dig(:formatSpecification, :title) }&.dig(:formatSpecification, :title) || ''
                end                

            end
         end
      end
   end
end
