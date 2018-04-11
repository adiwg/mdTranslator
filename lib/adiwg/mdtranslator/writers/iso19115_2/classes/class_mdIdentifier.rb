# ISO <<Class>> MD_Identifier
# 19115-2 output for ISO 19115-2 XML

# History:
#  Stan Smith 2018-04-10 add error and warning messaging
#  Stan Smith 2016-11-29 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-05-28 revised for json schema 0.5.0
# 	Stan Smith 2014-05-16 original script

require_relative '../iso19115_2_writer'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Identifier

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hIdentifier, inContext = nil)

                  # classes used in MD_Metadata
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  outContext = 'identifier'
                  outContext = inContext + ' authority' unless inContext.nil?

                  @xml.tag!('gmd:MD_Identifier') do

                     # identifier - authority
                     hCitation = hIdentifier[:citation]
                     unless hCitation.empty?
                        @xml.tag!('gmd:authority') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if hCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:authority')
                     end

                     # identifier - code (required)
                     s = hIdentifier[:identifier]
                     if s.nil?
                        @NameSpace.issueWarning(230, 'gmd:code', inContext)
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
