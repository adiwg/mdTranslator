# ISO <<Class>> MD_Identifier
# 19115-2 output for ISO 19115-2 XML

# History:
# 	Stan Smith 2017-11-02 original script

require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class MD_Identifier

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hIdentifier)

                  # classes used in MD_Metadata
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_Identifier') do

                     # identifier - authority
                     hCitation = hIdentifier[:citation]
                     unless hCitation.empty?
                        @xml.tag!('gmd:authority') do
                           citationClass.writeXML(hCitation)
                        end
                     end
                     if hCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:authority')
                     end

                     # identifier - code (required)
                     s = hIdentifier[:identifier]
                     if s.nil?
                        @xml.tag!('gmd:code', {'gco:nilReason' => 'missing'})
                     else
                        @xml.tag!('gmd:code') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end

                  end # MD_Identifier tag
               end # writeXML
            end # MD_Identifier class

         end
      end
   end
end
