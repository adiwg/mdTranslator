# FGDC <<Class>> TaxonomyClassification
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-12-13 original script

require_relative 'class_taxonomyClassification'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class TaxonomyClassification

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hClass)

                  # classes used
                  taxClassClass = TaxonomyClassification.new(@xml, @hResponseObj)

                  # taxonomy bio (taxonrn) - taxon rank (required)
                  unless hClass[:taxonRank].nil?
                     @xml.tag!('taxonrn', hClass[:taxonRank])
                  end
                  if hClass[:taxonRank].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Taxonomic Classification is missing taxon rank'
                  end

                  # taxonomy bio (taxonrv) - taxon value (required)
                  unless hClass[:taxonValue].nil?
                     @xml.tag!('taxonrv', hClass[:taxonValue])
                  end
                  if hClass[:taxonValue].nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Taxonomic Classification is missing latin name'
                  end

                  # taxonomy bio (common) - taxon value common names []
                  hClass[:commonNames].each do |hName|
                     @xml.tag!('common', hName)
                  end
                  if hClass[:commonNames].empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('common')
                  end

                  # taxonomy bio (taxoncl) - taxonomic sub-classification []
                  hClass[:subClasses].each do |hSubClass|
                     @xml.tag!('taxoncl') do
                        taxClassClass.writeXML(hSubClass)
                     end
                  end

               end # writeXML
            end # TaxonomyClassification

         end
      end
   end
end
