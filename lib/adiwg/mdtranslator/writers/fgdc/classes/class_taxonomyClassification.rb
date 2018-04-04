# FGDC <<Class>> TaxonomyClassification
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-26 refactored error and warning messaging
#  Stan Smith 2017-12-13 original script

require_relative '../fgdc_writer'
require_relative 'class_taxonomyClassification'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class TaxonomyClassification

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hClass)

                  # classes used
                  taxClassClass = TaxonomyClassification.new(@xml, @hResponseObj)

                  # taxonomy bio (taxonrn) - taxon rank (required)
                  unless hClass[:taxonRank].nil?
                     @xml.tag!('taxonrn', hClass[:taxonRank])
                  end
                  if hClass[:taxonRank].nil?
                     @NameSpace.issueWarning(410, 'taxonrn')
                  end

                  # taxonomy bio (taxonrv) - taxon value (required)
                  unless hClass[:taxonValue].nil?
                     @xml.tag!('taxonrv', hClass[:taxonValue])
                  end
                  if hClass[:taxonValue].nil?
                     @NameSpace.issueWarning(411, 'taxonrv')
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
