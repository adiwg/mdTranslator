# FGDC <<Class>> MethodKeyword
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-19 refactored error and warning messaging
#  Stan Smith 2017-12-20 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class MethodKeyword

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(aKeywords)
                  
                  # method bio (methodid) - lineage method keywords (required)
                  haveMethod = false
                  aKeywords.each do |hKeySet|
                     type = hKeySet[:keywordType]
                     if type == 'method'
                        aKeywords = hKeySet[:keywords]
                        hThesaurus = hKeySet[:thesaurus]
                        thesaurusName = nil
                        unless hThesaurus.empty?
                           thesaurusName = hThesaurus[:title]
                        end
                        @xml.tag!('methodid') do
                           unless thesaurusName.empty?
                              @xml.tag!('methkt', thesaurusName)
                           end
                           if thesaurusName.empty?
                              @NameSpace.issueWarning(221, 'methkt')
                           end
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
                     @NameSpace.issueWarning(220, nil)
                  end

               end # writeXML
            end # MethodKeyword

         end
      end
   end
end
