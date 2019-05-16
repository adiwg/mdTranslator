# ISO <<Class>> MD_Usage
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-03-25 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_timeInstant'
require_relative 'class_timePeriod'
require_relative 'class_responsibility'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_Usage

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hUsage)

                  # classes used in MD_Usage
                  instantClass = TimeInstant.new(@xml, @hResponseObj)
                  periodClass = TimePeriod.new(@xml, @hResponseObj)
                  responsibilityClass = CI_Responsibility.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)

                  outContext = 'resource usage'

                  @xml.tag!('mri:MD_Usage') do

                     # usage - specific usage (required)
                     unless hUsage[:specificUsage].nil?
                        @xml.tag!('mri:specificUsage') do
                           @xml.tag!('gco:CharacterString', hUsage[:specificUsage])
                        end
                     end
                     if hUsage[:specificUsage].nil?
                        @NameSpace.issueWarning(320, 'mri:specificUsage')
                     end

                     # usage - dateTime [0] {TimeInstant | TimePeriod}
                     aExtents = hUsage[:temporalExtents]
                     aExtents.each do |hExtent|
                        unless hExtent.empty?
                           haveTime = false
                           unless hExtent[:timeInstant].empty?
                              @xml.tag!('mri:usageDateTime') do
                                 instantClass.writeXML(hExtent[:timeInstant])
                              end
                              haveTime = true
                           end
                           unless hExtent[:timePeriod].empty?
                              @xml.tag!('mri:usageDateTime') do
                                 periodClass.writeXML(hExtent[:timePeriod])
                              end
                              haveTime = true
                           end
                           if !haveTime
                              @NameSpace.issueWarning(410, 'mri:usageDateTime', outContext)
                           end
                        end
                     end
                     if aExtents.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:usageDateTime')
                     end

                     # usage - user determined limitations
                     unless hUsage[:userLimitation].nil?
                        @xml.tag!('mri:userDeterminedLimitations') do
                           @xml.tag!('gco:CharacterString', hUsage[:userLimitation])
                        end
                     end
                     if hUsage[:userLimitation].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:userDeterminedLimitations')
                     end

                     # usage - user contact info [] {CI_Responsibility}
                     aResponsibility = hUsage[:userContacts]
                     aResponsibility.each do |hResponsibility|
                        @xml.tag!('mri:userContactInfo') do
                           responsibilityClass.writeXML(hResponsibility, outContext)
                        end
                     end
                     if aResponsibility.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:userContactInfo')
                     end

                     # usage - response []
                     aResponses = hUsage[:limitationResponses]
                     aResponses.each do |hResponse|
                        @xml.tag!('mri:response') do
                           @xml.tag!('gco:CharacterString', hResponse)
                        end
                     end
                     if aResponses.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:response')
                     end

                     # usage - additional documentation [] {CI_Citation}
                     aDocuments = hUsage[:additionalDocumentation]
                     aDocuments.each do |hDocument|
                        @xml.tag!('mri:additionalDocumentation') do
                           citationClass.writeXML(hDocument, outContext)
                        end
                     end
                     if aDocuments.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:additionalDocumentation')
                     end

                     # usage - identification issues {CI_Citation}
                     unless hUsage[:identifiedIssue].empty?
                        @xml.tag!('mri:identifiedIssues') do
                           citationClass.writeXML(hUsage[:identifiedIssue], outContext)
                        end
                     end
                     if hUsage[:identifiedIssue].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mri:identifiedIssues')
                     end

                  end # mri:MD_Usage tag
               end # writeXML
            end # MD_Usage class

         end
      end
   end
end
