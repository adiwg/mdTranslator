# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Distribution

               def self.build(intObj)
                  resourceInfo = intObj[:metadata][:resourceInfo]
                  citation = resourceInfo[:citation]
                  distributions = []
                  if citation[:onlineResources]
                     citation[:onlineResources].each do |resource|
                        if resource[:olResURI]
                           accessURL = resource[:olResURI]
                           distribution = Jbuilder.new do |json|
                              json.set!('@type', 'dcat:Distribution')
                              json.set!('dcat:accessURL', accessURL)
                           end
                           distributions << distribution.attributes!
                        end
                     end
                  end
                  distributions
               end           

            end
         end
      end
   end
end
