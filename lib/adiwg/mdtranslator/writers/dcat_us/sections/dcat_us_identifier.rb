# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Identifier

               def self.build(intObj)
                  identifiers = intObj.dig(:metadata, :resourceInfo, :citation, :identifiers)
                  uri = intObj.dig(:metadata, :resourceInfo, :citation, :onlineResources, 0, :olResURI)
                
                  namespace_is_doi = identifiers&.any? { |identifier| identifier[:namespace]&.casecmp?("DOI") }
                
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
