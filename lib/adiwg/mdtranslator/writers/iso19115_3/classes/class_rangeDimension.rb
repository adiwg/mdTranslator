# ISO <<Class>> MD_RangeDimension attributes
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-04-08 original script.

require_relative '../iso19115_3_writer'
require_relative 'class_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_RangeDimension

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hAttribute, inContext = nil)

                  # classes used
                  identifierClass = MD_Identifier.new(@xml, @hResponseObj)

                  outContext = 'attribute'
                  outContext = inContext + ' attribute' unless inContext.nil?

                  # range dimension - sequence identifier {MemberName}
                  haveSeqId = false
                  haveSeqId = true unless hAttribute[:sequenceIdentifier].nil?
                  haveSeqId = true unless hAttribute[:sequenceIdentifierType].nil?
                  if haveSeqId
                     @xml.tag!('mrc:sequenceIdentifier') do
                        @xml.tag!('gco:MemberName') do

                           unless hAttribute[:sequenceIdentifier].nil?
                              @xml.tag!('gco:aName') do
                                 @xml.tag!('gco:CharacterString', hAttribute[:sequenceIdentifier])
                              end
                           end
                           if hAttribute[:sequenceIdentifier].nil?
                              @NameSpace.issueWarning(350, 'gco:aName', outContext)
                           end

                           unless hAttribute[:sequenceIdentifierType].nil?
                              @xml.tag!('gco:attributeType') do
                                 @xml.tag!('gco:TypeName') do
                                    @xml.tag!('gco:aName') do
                                       @xml.tag!('gco:CharacterString', hAttribute[:sequenceIdentifierType])
                                    end
                                 end
                              end
                           end
                           if hAttribute[:sequenceIdentifierType].nil?
                              @NameSpace.issueWarning(351, 'gco:aName', outContext)
                           end
                        end
                     end
                  end
                  if !haveSeqId && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:sequenceIdentifier')
                  end

                  # range dimension - description
                  unless hAttribute[:attributeDescription].nil?
                     @xml.tag!('mrc:description') do
                        @xml.tag!('gco:CharacterString', hAttribute[:attributeDescription])
                     end
                  end
                  if hAttribute[:attributeDescription].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:description')
                  end

                  # range dimension - name [] {MD_Identifier}
                  aNames = hAttribute[:attributeIdentifiers]
                  aNames.each do |hIdentifier|
                     @xml.tag!('mrc:name') do
                        identifierClass.writeXML(hIdentifier, outContext)
                     end
                  end
                  if aNames.empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:name')
                  end

               end # writeXML
            end # MD_RangeDescription

         end
      end
   end
end
