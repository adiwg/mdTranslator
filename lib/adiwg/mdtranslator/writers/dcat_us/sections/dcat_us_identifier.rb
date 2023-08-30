# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Identifier

               def self.build(intObj)
                  citation = intObj.dig(:metadata, :resourceInfo, :citation)
                  identifiers = citation&.dig(:identifiers)
                  onlineResources = citation&.dig(:onlineResources)
                  uri = onlineResources.dig(0, :olResURI)
                  
                  puts "citation: #{citation}"
                  # puts "uri: #{uri}"
                
                  namespace_is_doi = identifiers&.any? { |identifier| identifier[:namespace]&.casecmp?("DOI") }
                  # puts "namespace_is_doi: #{namespace_is_doi}"
                
                  if namespace_is_doi
                    return uri
                  elsif uri && uri.downcase.include?("doi")
                    return uri
                  end
                
                  nil
               end
                                    

            end
         end
      end
   end
end
