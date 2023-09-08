require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module DescribedBy

               def self.build(intObj)
                  dataDictionaries = intObj[:dataDictionaries]
                
                  dataDictionaries.each do |dataDictionary|
                    if !dataDictionary[:dictionaryIncludedWithResource]
                      onlineResources = dataDictionary[:citation][:onlineResources]
                      onlineResources.each do |resource|
                        if resource[:olResURI]
                          return resource[:olResURI]
                        end
                      end
                    end
                  end
                
                  return nil
                end                
                
            end
         end
      end
   end
end
