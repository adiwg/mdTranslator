# ISO <<Class>> TaxonomicSystem
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-09 original script.

require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class TaxonomicSystem

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hSystem)

                  # classes used
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  # taxon system - citation {CI_Citation}
                  hCitation = hSystem[:citation]
                  unless hCitation.empty?
                     citationClass.writeXML(hCitation, 'taxonomic system')
                  end

                  # taxon system - modifications
                  s = hSystem[:modifications]
                  unless s.nil?
                     @xml.tag!('gmd:classmod') do
                        @xml.tag!('gco:CharacterString', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:classmod')
                  end

               end # writeXML
            end # TaxonomicSystem class

         end
      end
   end
end
