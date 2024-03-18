require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module DescribedByType

               def self.build(intObj)

                  #  metadataInfo[:metadataOnlineOptions][0][:olResProtocol]
                  dataDictionaries = intObj[:dataDictionaries]
                  describedByType = ''
                  dataDictionaries.each do |dataDictionary|
                     unless dataDictionary[:includedWithDataset]
                        onlineResources = dataDictionary[:citation][:onlineResources]
                        onlineResources.each do |resource|
                           if resource[:olResURI] && !resource[:olResURI].end_with?('.html')
                              describedByType = resource[:olResProtocol]
                              break
                           end
                        end
                     end
                  end
                
                  describedByType
               end                

            end
         end
      end
   end
end
