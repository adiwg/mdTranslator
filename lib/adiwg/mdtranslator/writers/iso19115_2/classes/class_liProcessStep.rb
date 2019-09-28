# ISO <<Class>> LI_ProcessStep
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-10 add error and warning messaging
#  Stan Smith 2017-08-30 added support for step sources
#  Stan Smith 2016-12-13 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-20 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_responsibleParty'
require_relative 'class_source'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class LI_ProcessStep

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hStep, inContext = nil)

                  # classes used
                  partyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                  sourceClass = Source.new(@xml, @hResponseObj)

                  outContext = 'process step'
                  outContext = outContext + ' ' + hStep[:stepId].to_s unless hStep[:stepId].nil?
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  # process step - id
                  attributes = {}
                  s = hStep[:stepId]
                  unless s.nil?
                     attributes = { id: s.gsub(/[^0-9A-Za-z]/,'') }
                  end

                  @xml.tag!('gmd:LI_ProcessStep', attributes) do

                     # process step - description (required)
                     s = hStep[:description]
                     unless s.nil?
                        @xml.tag!('gmd:description') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(260, 'gmd:description', outContext)
                     end

                     # process step - rationale
                     s = hStep[:rationale]
                     unless s.nil?
                        @xml.tag!('gmd:rationale') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
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

                  end # gmd:LI_ProcessStep tag
               end # writeXML
            end # LI_ProcessStep class

         end
      end
   end
end
