# ISO <<Class>> MD_BrowseGraphic
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-15 original script

require_relative '../iso19115_1_writer'
require_relative 'class_constraint'
require_relative 'class_onlineResource'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_BrowseGraphic

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hGraphic, inContext = nil)

                  # classes used
                  onlineClass = CI_OnlineResource.new(@xml, @hResponseObj)
                  constraintClass = ConstraintClass.new(@xml, @hResponseObj)

                  outContext = 'browse graphic'
                  outContext = inContext + ' browse graphic' unless inContext.nil?

                  @xml.tag!('mcc:MD_BrowseGraphic') do

                     # browse graphic - file name (required)
                     s = hGraphic[:graphicName]
                     unless s.nil?
                        @xml.tag!('mcc:fileName') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(20, 'mcc:fileName', outContext)
                     end

                     # browse graphic - file description
                     s = hGraphic[:graphicDescription]
                     unless s.nil?
                        @xml.tag!('mcc:fileDescription') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mcc:fileDescription')
                     end

                     # browse graphic - file type
                     s = hGraphic[:graphicType]
                     unless s.nil?
                        @xml.tag!('mcc:fileType') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mcc:fileType')
                     end

                     # browse graphic - image constraint [] {MD_Constraints}
                     aConstraint = hGraphic[:graphicURI]
                     aConstraint.each do |hCon|
                        @xml.tag!('mcc:imageConstraints') do
                           constraintClass.writeXML(hCon, outContext)
                        end
                     end
                     if aConstraint.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mcc:imageConstraints')
                     end

                     # browse graphic - linkage [] {CI_OnlineResource}
                     aOnline = hGraphic[:graphicURI]
                     aOnline.each do |hOnline|
                        @xml.tag!('mcc:linkage') do
                           onlineClass.writeXML(hOnline, outContext)
                        end
                     end
                     if aOnline.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mcc:linkage')
                     end

                  end # MD_BrowseGraphic tag
               end # writeXML
            end # MD_BrowseGraphic class

         end
      end
   end
end
