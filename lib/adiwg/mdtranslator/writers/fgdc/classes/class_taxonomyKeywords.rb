# FGDC <<Class>> TaxonomyKeyword
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-12-13 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class TaxonomyKeyword

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aKeywords)

                  # taxonomy bio (keywtax) - taxonomic keywords (required)
                  haveTaxon = false
                  aKeywords.each do |hKeySet|
                     type = hKeySet[:keywordType]
                     if type == 'taxon'
                        aKeywords = hKeySet[:keywords]
                        thesaurus = hKeySet[:thesaurus]
                        if thesaurus.empty?
                           @hResponseObj[:writerPass] = false
                           @hResponseObj[:writerMessages] << 'Taxonomy Keyword Set is missing thesaurus'
                        end
                        @xml.tag!('keywtax') do
                           @xml.tag!('taxonkt', thesaurus[:title])
                           aKeywords.each do |hKeyword|
                              keyword = hKeyword[:keyword]
                              unless keyword.nil?
                                 @xml.tag!('taxonkey', keyword)
                                 haveTaxon = true
                              end
                           end
                        end
                     end
                  end
                  unless haveTaxon
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Taxonomy is missing keyword set'
                  end

               end # writeXML
            end # TaxonomyKeyword

         end
      end
   end
end
