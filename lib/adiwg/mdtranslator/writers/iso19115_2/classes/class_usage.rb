# ISO <<Class>> MD_Usage
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-10 add error and warning messaging
#  Stan Smith 2016-12-12 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-19 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_responsibleParty'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Usage

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hUsage)

                  # classes used in MD_Usage
                  partyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_Usage') do

                     # usage - specific usage (required)
                     s = hUsage[:specificUsage]
                     unless s.nil?
                        @xml.tag!('gmd:specificUsage') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(320, 'gmd:specificUsage')
                     end

                     # usage - dateTime [0]
                     aTimes = hUsage[:temporalExtents]
                     dateStr = nil
                     unless aTimes.empty?
                        hTime = aTimes[0]
                        unless hTime.empty?
                           hInstant = hTime[:timeInstant]
                           hPeriod = hTime[:timePeriod]
                           unless hInstant.empty?
                              hDateTime = hInstant[:timeInstant]
                              timeInstant = hDateTime[:dateTime]
                              timeResolution = hDateTime[:dateResolution]
                              dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(timeInstant, timeResolution)
                              hPeriod = {}
                           end
                           unless hPeriod.empty?
                              hStart = hPeriod[:startDateTime]
                              hEnd = hPeriod[:endDateTime]
                              if !hStart.empty?
                                 dateTime = hStart[:dateTime]
                                 timeResolution = hStart[:dateResolution]
                              else
                                 dateTime = hEnd[:dateTime]
                                 timeResolution = hEnd[:dateResolution]
                              end
                              dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(dateTime, timeResolution)
                           end
                        end
                     end
                     unless dateStr.nil?
                        @xml.tag!('gmd:usageDateTime') do
                           @xml.tag!('gco:DateTime', dateStr)
                        end
                     end
                     if dateStr.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:usageDateTime')
                     end

                     # usage - user determined limitations
                     s = hUsage[:userLimitation]
                     unless s.nil?
                        @xml.tag!('gmd:userDeterminedLimitations') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:userDeterminedLimitations')
                     end

                     # usage - user contact info (required (optional -1)) [{CI_ResponsibleParty}]
                     aParties = hUsage[:userContacts]
                     aParties.each do |hRParty|
                        role = hRParty[:roleName]
                        aParties = hRParty[:parties]
                        aParties.each do |hParty|
                           @xml.tag!('gmd:userContactInfo') do
                              partyClass.writeXML(role, hParty, 'resource specific usage')
                           end
                        end
                     end
                     if aParties.empty?
                        @NameSpace.issueWarning(321, 'gmd:userContactInfo')
                     end

                  end # gmd:MD_Usage tag
               end # writeXML
            end # MD_Usage class

         end
      end
   end
end
