require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module SystemOfRecords

               def self.build(intObj)
                  associatedResources = intObj.dig(:metadata, :associatedResources)
                  
                  return nil if associatedResources.nil?
                
                  associatedResources.each do |resource|
                    if resource[:initiativeType] == 'sorn'
                      onlineResources = resource.dig(:resourceCitation, :onlineResources)
                      return onlineResources.first[:olResURI] if onlineResources&.first&.has_key?(:olResURI)
                    end
                  end
                  
                  return nil
               end

            end
         end
      end
   end
end
