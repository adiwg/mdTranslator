# unpack description
# Reader - DCAT-US to internal data structure

module ADIWG
   module Mdtranslator
      module Readers
         module Dcat_us

            module Description

               def self.unpack(hDataset, hResourceInfo, hResponseObj)

                  if hDataset.has_key?('description')
                     desc = hDataset['description']
                     unless desc.nil? || desc == ''
                        hResourceInfo[:abstract] = desc
                     end
                  end

                  return hResourceInfo

               end

            end

         end
      end
   end
end
