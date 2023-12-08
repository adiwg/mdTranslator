# ISO <<Class>> MD_Identifier for specific party identfier features for individual and organization
# 19115-3 output for ISO 19115-3 XML

require_relative '../iso19115_3_writer'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_PartyIdentifier

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hIdentifier, inContext = nil)

                  outContext = 'identifier'
                  outContext = inContext + ' authority' unless inContext.nil?

                  # classes used in MD_Metadata
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  @xml.tag!('mcc:MD_Identifier') do

                     # identifier - authority {CI_Citation}
                     hCitation = hIdentifier[:citation]
                     unless hCitation.nil? || hCitation.empty?
                        @xml.tag!('mcc:authority') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if hCitation.nil? || hCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mcc:authority')
                     end

                     # identifier - code (required)
                     s = hIdentifier[:identifier]
                     unless s.nil?
                        @xml.tag!('mcc:code') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(230, 'mcc:code', inContext)
                     end

                     # identifier - codeSpace
                     s = hIdentifier[:namespace]
                     unless s.nil?
                        @xml.tag!('mcc:codeSpace') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mcc:codeSpace')
                     end

                     # identifier - codeSpace version
                     s = hIdentifier[:version]
                     unless s.nil?
                        @xml.tag!('mcc:version') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mcc:version')
                     end

                     # identifier - description
                     s = hIdentifier[:description]
                     unless s.nil?
                        @xml.tag!('mcc:description') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mcc:description')
                     end

                  end # MD_Identifier tag
               end # writeXML
            end # MD_Identifier class

         end
      end
   end
end
