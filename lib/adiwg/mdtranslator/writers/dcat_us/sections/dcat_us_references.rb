require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module References

               def self.build(intObj)
                  metadata = intObj.dig(:metadata)
                  associated_resources = metadata&.dig(:associatedResources)
                  additional_documents = metadata&.dig(:additionalDocuments)
                  uris = []
                
                  if associated_resources
                    associated_resources.each do |associated|
                      citation = associated.dig(:resourceCitation)
                      online_resources = citation&.dig(:onlineResources)
                      next unless online_resources
                
                      online_resources.each do |online|
                        uri = online.dig(:olResURI)
                        uris << uri if uri
                      end
                    end
                  end
                
                  if additional_documents
                    additional_documents.each do |additional|
                      citations = additional&.dig(:citation) || []
                      citations.each do |citation|
                        online_resources = citation&.dig(:onlineResources)
                        next unless online_resources
                
                        online_resources.each do |online|
                          uri = online.dig(:olResURI)
                          uris << uri if uri
                        end
                      end
                    end
                  end
                
                  uris.join(',')
               end

            end
         end
      end
   end
end
