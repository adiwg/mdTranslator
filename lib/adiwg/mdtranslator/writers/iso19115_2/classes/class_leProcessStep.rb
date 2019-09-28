# ISO <<Class>> LE_ProcessStep
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2019-09-25 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_responsibleParty'
require_relative 'class_source'
require_relative 'class_processing'
require_relative 'class_processReport'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class LE_ProcessStep

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hStep, inContext = nil)

                  # classes used
                  partyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                  sourceClass = Source.new(@xml, @hResponseObj)
                  processingClass = LE_Processing.new(@xml, @hResponseObj)
                  reportClass = LE_ProcessStepReport.new(@xml, @hResponseObj)

                  outContext = 'process step'
                  outContext = outContext + ' ' + hStep[:stepId].to_s unless hStep[:stepId].nil?
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  # process step - id
                  attributes = {}
                  s = hStep[:stepId]
                  unless s.nil?
                     attributes = { id: s.gsub(/[^0-9A-Za-z]/,'') }
                  end

                  @xml.tag!('gmi:LE_ProcessStep', attributes) do

                     # process step - description (required)
                     unless hStep[:description].nil?
                        @xml.tag!('gmd:description') do
                           @xml.tag!('gco:CharacterString', hStep[:description])
                        end
                     end
                     if hStep[:description].nil?
                        @NameSpace.issueWarning(260, 'gmd:description', outContext)
                     end

                     # process step - rationale
                     unless hStep[:rationale].nil?
                        @xml.tag!('gmd:rationale') do
                           @xml.tag!('gco:CharacterString', hStep[:rationale])
                        end
                     end
                     if hStep[:rationale].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:rationale')
                     end

                     # process step - datetime
                     hPeriod = hStep[:timePeriod]
                     unless hPeriod.empty?
                        hDate = hPeriod[:startDateTime]
                        if hDate.empty?
                           hDate = hPeriod[:endDateTime]
                        end
                        date = hDate[:dateTime]
                        dateResolution = hDate[:dateResolution]
                        s = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, dateResolution)
                        if s != 'ERROR'
                           @xml.tag!('gmd:dateTime') do
                              @xml.tag!('gco:DateTime', s)
                           end
                        end
                     end
                     if hPeriod.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:dateTime')
                     end

                     # process step - processor [] {CI_ResponsibleParty}
                     aParties = hStep[:processors]
                     aParties.each do |hRParty|
                        role = hRParty[:roleName]
                        aParties = hRParty[:parties]
                        aParties.each do |hParty|
                           @xml.tag!('gmd:processor') do
                              partyClass.writeXML(role, hParty, outContext)
                           end
                        end
                     end
                     if aParties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:processor')
                     end

                     # process step - source [] {Source}
                     aSources = hStep[:stepSources]
                     aSources.each do |hSource|
                        @xml.tag!('gmd:source') do
                           sourceClass.writeXML(hSource)
                        end
                     end
                     if aSources.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:source')
                     end

                     # process step - processing information {LE_Processing}
                     hProcessing = hStep[:processingInformation]
                     unless hProcessing.empty?
                        @xml.tag!('gmi:processingInformation') do
                           processingClass.writeXML(hProcessing, outContext)
                        end
                     end
                     if hProcessing.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:processingInformation')
                     end

                     # process step - output [] {Source}
                     aOutput = hStep[:stepProducts]
                     aOutput.each do |hSource|
                        @xml.tag!('gmi:output') do
                           sourceClass.writeXML(hSource)
                        end
                     end
                     if aOutput.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:output')
                     end

                     # process step - report [] {LE_ProcessStepReport}
                     aReports = hStep[:reports]
                     aReports.each do |hReport|
                        @xml.tag!('gmi:report') do
                           reportClass.writeXML(hReport)
                        end
                     end
                     if aReports.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:report')
                     end

                  end # gmd:LE_ProcessStep tag
               end # writeXML
            end # LE_ProcessStep class

         end
      end
   end
end
