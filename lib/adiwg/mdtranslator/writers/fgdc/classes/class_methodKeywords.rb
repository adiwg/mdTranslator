# FGDC <<Class>> MethodKeyword
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-12-20 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class MethodKeyword

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aKeywords)

                  # method bio (methodid) - lineage method keywords (required)
                  haveMethod = false
                  aKeywords.each do |hKeySet|
                     type = hKeySet[:keywordType]
                     if type == 'method'
                        aKeywords = hKeySet[:keywords]
                        thesaurus = hKeySet[:thesaurus]
                        if thesaurus.empty?
                           @hResponseObj[:writerPass] = false
                           @hResponseObj[:writerMessages] << 'Lineage Method Keyword Set is missing thesaurus'
                        end
                        @xml.tag!('methodid') do
                           @xml.tag!('methkt', thesaurus[:title])
                           aKeywords.each do |hKeyword|
                              keyword = hKeyword[:keyword]
                              unless keyword.nil?
                                 @xml.tag!('methkey', keyword)
                                 haveMethod = true
                              end
                           end
                        end
                     end
                  end
                  unless haveMethod
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Lineage Method is missing keyword set'
                  end

               end # writeXML
            end # MethodKeyword

         end
      end
   end
end
