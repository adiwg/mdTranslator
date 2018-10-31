# FGDC <<Class>> Taxonomy
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-10-19 refactored for mdJson schema 2.6.0
#  Stan Smith 2018-03-26 refactored error and warning messaging
#  Stan Smith 2017-12-12 original script

require_relative '../fgdc_writer'
require_relative 'class_taxonomyKeywords'
require_relative 'class_taxonomySystem'
require_relative 'class_taxonomyClassification'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Taxonomy

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hTaxonomy, aKeywords)

                  # classes used
                  keywordClass = TaxonomyKeyword.new(@xml, @hResponseObj)
                  taxSystemClass = TaxonomySystem.new(@xml, @hResponseObj)
                  taxClassClass = TaxonomyClassification.new(@xml, @hResponseObj)

                  # taxonomy bio (keywtax) - taxonomic keywords (required)
                  unless aKeywords.empty?
                     keywordClass.writeXML(aKeywords)
                  end
                  if aKeywords.empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('keywtax')
                  end

                  # taxonomy bio (taxonsys) - taxonomic system
                  # section is not required for fgdc, but is required by mdJson
                  # so section will always be present
                  @xml.tag!('taxonsys') do
                     taxSystemClass.writeXML(hTaxonomy)
                  end

                  # taxonomy (taxongen) - general scope
                  unless hTaxonomy[:generalScope].nil?
                     @xml.tag!('taxongen', hTaxonomy[:generalScope])
                  end
                  if hTaxonomy[:generalScope].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('taxongen')
                  end

                  # taxonomy bio (taxoncl) - taxonomic classification [0] {required}
                  unless hTaxonomy[:taxonClasses].empty?
                     @xml.tag!('taxoncl') do
                        taxClassClass.writeXML(hTaxonomy[:taxonClasses][0])
                     end
                  end
                  if hTaxonomy[:taxonClasses].length > 1
                     @NameSpace.issueNotice(401)
                     @NameSpace.issueNotice(402)
                  end
                  if hTaxonomy[:taxonClasses].empty?
                     @NameSpace.issueWarning(400, 'taxoncl')
                  end

               end # writeXML
            end # Taxonomy

         end
      end
   end
end
