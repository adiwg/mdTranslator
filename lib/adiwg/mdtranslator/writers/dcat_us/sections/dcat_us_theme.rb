require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module Theme

               def self.build(intObj)
                  resourceInfo = intObj[:metadata][:resourceInfo]
                  keywords_str = []
                
                  resourceInfo[:keywords].each do |keyword_group|
                    if keyword_group[:thesaurus][:title] == "ISO Topic Categories"
                      keyword_group[:keywords].each do |keyword_obj|
                        keywords_str << keyword_obj[:keyword]
                      end
                    end
                  end
                
                  return keywords_str.join(" ")
               end                

            end
         end
      end
   end
end
