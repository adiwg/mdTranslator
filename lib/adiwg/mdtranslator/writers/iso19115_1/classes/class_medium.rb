# ISO <<Class>> MD_Medium
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-10 original script.

require_relative 'class_citation'
require_relative 'class_identifier'
require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Medium

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hMedium, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  identifierClass = MD_Identifier.new(@xml, @hResponseObj)

                  outContext = 'medium'
                  outContext = inContext + ' medium' unless inContext.nil?

                  @xml.tag!('mrd:MD_Medium') do

                     # medium - name {CI_Citation}
                     unless hMedium[:mediumSpecification].empty?
                        @xml.tag!('mrd:name') do
                           citationClass.writeXML(hMedium[:mediumSpecification], outContext)
                        end
                     end
                     if hMedium[:mediumSpecification].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:name')
                     end

                     # medium - density {Real}
                     unless hMedium[:density].nil?
                        @xml.tag!('mrd:density') do
                           @xml.tag!('gco:Real', hMedium[:density].to_s)
                        end
                     end
                     if hMedium[:density].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:density')
                     end

                     # medium density units
                     unless hMedium[:units].nil?
                        @xml.tag!('mrd:densityUnits') do
                           @xml.tag!('gco:CharacterString', hMedium[:units].downcase)
                        end
                     end
                     if hMedium[:units].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:densityUnits')
                     end

                     # medium - volumes {Integer}
                     unless hMedium[:numberOfVolumes].nil?
                        @xml.tag!('mrd:volumes') do
                           @xml.tag!('gco:Integer', hMedium[:numberOfVolumes].to_s)
                        end
                     end
                     if hMedium[:numberOfVolumes].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:volumes')
                     end

                     # medium - medium format code [] {MD_MediumFormatCode}
                     aCode = hMedium[:mediumFormat]
                     aCode.each do |code|
                        @xml.tag!('mrd:mediumFormat') do
                           codelistClass.writeXML('mrd', 'iso_mediumFormat', code)
                        end
                     end
                     if aCode.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:mediumFormat')
                     end

                     # medium - note
                     unless hMedium[:note].nil?
                        @xml.tag!('mrd:mediumNote') do
                           @xml.tag!('gco:CharacterString', hMedium[:note])
                        end
                     end
                     if hMedium[:note].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:mediumNote')
                     end

                     # medium - identifier {MD_Identifier}
                     unless hMedium[:identifier].empty?
                        @xml.tag!('mrd:identifier') do
                           identifierClass.writeXML(hMedium[:identifier], outContext)
                        end
                     end
                     if hMedium[:identifier].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrd:identifier')
                     end

                  end # mrd:MD_Medium
               end # writeXML
            end # MD_Medium class

         end
      end
   end
end
