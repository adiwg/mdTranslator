# ISO <<Class>> TimeInstant
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-19 original script.

require_relative 'class_gmlIdentifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class TimeInstant

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hInstant)

                  # classes used
                  gmlClass = GMLIdentifier.new(@xml, @hResponseObj)

                  # TimeInstant requires a unique ID
                  timeID = hInstant[:timeId]
                  if timeID.nil?
                     @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                     timeID = 'timeInstant' + @hResponseObj[:writerMissingIdCount]
                  else
                     timeID.gsub!(/[^0-9a-zA-Z]/, '')
                  end

                  @xml.tag!('gml:TimeInstant', {'gml:id' => timeID}) do

                     # time instant - description
                     unless hInstant[:description].nil?
                        @xml.tag!('gml:description', hInstant[:description])
                     end
                     if hInstant[:description].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:description')
                     end

                     # time instant - identifier {gmlIdentifier}
                     hGMLid = hInstant[:identifier]
                     unless hGMLid.empty?
                        gmlClass.writeXML(hGMLid)
                     end
                     if hGMLid.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:identifier', {'codeSpace' => ''})
                     end

                     # time instant - names []
                     aNames = hInstant[:instantNames]
                     aNames.each do |name|
                        @xml.tag!('gml:name', name)
                     end
                     if aNames.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:name')
                     end

                     # time instant - related Time [] { TmeInstant | TimePeriod}
                     # not implemented

                     # time instant - time position
                     hDateTime = hInstant[:timeInstant]
                     timeInstant = hDateTime[:dateTime]
                     timeResolution = hDateTime[:dateResolution]
                     dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(timeInstant, timeResolution)
                     @xml.tag!('gml:timePosition', dateStr)

                  end # TimeInstant tag
               end # writeXML
            end # TimeInstant class

         end
      end
   end
end
