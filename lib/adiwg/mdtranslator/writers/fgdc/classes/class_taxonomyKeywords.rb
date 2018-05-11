# FGDC <<Class>> TaxonomyKeyword
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-26 refactored error and warning messaging
#  Stan Smith 2017-12-13 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class TaxonomyKeyword

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(aKeywords)

                  # taxonomy bio (keywtax) - taxonomic keywords (required)
                  haveTaxKeyword = false
                  aKeywords.each do |hKeySet|
                     type = hKeySet[:keywordType]
                     if type == 'taxon'
                        haveTaxKeyword = true
                        @xml.tag!('keywtax') do
                           aKeywords = hKeySet[:keywords]
                           thesaurus = hKeySet[:thesaurus]
                           unless thesaurus.empty?
                              @xml.tag!('taxonkt', thesaurus[:title])
                           end
                           if thesaurus.empty?
                              @NameSpace.issueWarning(420, 'taxonkt')
                           end
                           aKeywords.each do |hKeyword|
                              keyword = hKeyword[:keyword]
                              unless keyword.nil?
                                 @xml.tag!('taxonkey', keyword)
                              end
                           end
                           if aKeywords.empty?
                              @NameSpace.issueWarning(421, 'taxonkey')
                           end
                        end
                     end
                  end
                  unless haveTaxKeyword
                     @NameSpace.issueWarning(422)
                  end

               end # writeXML
            end # TaxonomyKeyword

         end
      end
   end
end
