# ISO <<Class>> MD_AssociatedResource
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-04-22 original script

require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class AdditionalDocument

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hAdditionalDoc, inContext = nil)

                  # classes used
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  outContext = 'additional document'
                  outContext = inContext + ' additional document' unless inContext.nil?

                  # additional document - resource type [] {MD_ScopeCode} - not used by ISO

                  # additional document - additional documentation [] {CI_Citation}
                  aDocs = hAdditionalDoc[:citation]
                  aDocs.each do |hCitation|
                     unless hCitation.empty?
                        @xml.tag!('mri:additionalDocumentation') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                  end

               end # writeXML
            end # AdditionalDocument class

         end
      end
   end
end
