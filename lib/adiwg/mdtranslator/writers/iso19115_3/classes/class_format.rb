# ISO <<Class>> MD_Format
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-22 original script

require_relative '../iso19115_3_writer'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_Format

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hFormat, inContext = nil)

                  # classes used
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  outContext = 'format'
                  outContext = inContext + ' format' unless inContext.nil?

                  @xml.tag!('mrd:MD_Format') do

                     # format - format specification citation {CI_Citation} (required)
                     unless hFormat[:formatSpecification].empty?
                        @xml.tag!('mrd:formatSpecificationCitation') do
                           citationClass.writeXML(hFormat[:formatSpecification], outContext)
                        end
                     end
                     if hFormat[:formatSpecification].empty?
                        @NameSpace.issueWarning(120, 'gmd:name', inContext)
                     end

                     # format - amendment number
                     unless hFormat[:amendmentNumber].nil?
                        @xml.tag!('mrd:amendmentNumber') do
                           @xml.tag!('gco:CharacterString', hFormat[:amendmentNumber])
                        end
                     end
                     if hFormat[:amendmentNumber].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:amendmentNumber')
                     end

                     # format - file decompression method
                     unless hFormat[:compressionMethod].nil?
                        @xml.tag!('mrd:fileDecompressionTechnique') do
                           @xml.tag!('gco:CharacterString',hFormat[:compressionMethod])
                        end
                     end
                     if hFormat[:compressionMethod].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:fileDecompressionTechnique')
                     end

                     # format - medium [] {MD_Medium} - not implemented in MD_Format

                     # format - distributor [] {MD_Distributor} - not implemented in MD_Format

                  end # MD_Format tag
               end # writeXML
            end # MD_Format class

         end
      end
   end
end
