# ISO <<Class>> MD_RangeDimension attributes
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-17 add error and warning messaging
#  Stan Smith 2016-11-29 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-08-27 original script.

require_relative '../iso19115_2_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_RangeDimension

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hAttribute)

                  # range dimension - sequence identifier {MemberName}
                  haveSeqId = false
                  haveSeqId = true unless hAttribute[:sequenceIdentifier].nil?
                  haveSeqId = true unless hAttribute[:sequenceIdentifierType].nil?
                  if haveSeqId
                     @xml.tag!('gmd:sequenceIdentifier') do
                        @xml.tag!('gco:MemberName') do

                           unless hAttribute[:sequenceIdentifier].nil?
                              @xml.tag!('gco:aName') do
                                 @xml.tag!('gco:CharacterString', hAttribute[:sequenceIdentifier])
                              end
                           end
                           if hAttribute[:sequenceIdentifier].nil?
                              @NameSpace.issueWarning(350, 'gco:aName', 'coverage description attribute')
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
                              @NameSpace.issueWarning(351, 'gco:aName', 'coverage description attribute')
                           end
                        end
                     end
                  end
                  if !haveSeqId && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:sequenceIdentifier')
                  end

                  # range dimension - descriptor
                  unless hAttribute[:attributeDescription].nil?
                     @xml.tag!('gmd:descriptor') do
                        @xml.tag!('gco:CharacterString', hAttribute[:attributeDescription])
                     end
                  end
                  if hAttribute[:attributeDescription].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('gmd:descriptor')
                  end

               end # writeXML
            end # MD_RangeDescription attributes

         end
      end
   end
end
