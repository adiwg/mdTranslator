require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module PrimaryITInvestmentUII

               def self.build(intObj)
                  primaryITInvestmentUII = intObj[:metadata][:metadataInfo][:metadataIdentifier][:identifier]
                  
                  primaryITInvestmentUII ? primaryITInvestmentUII : nil
                end
                
            end
         end
      end
   end
end
