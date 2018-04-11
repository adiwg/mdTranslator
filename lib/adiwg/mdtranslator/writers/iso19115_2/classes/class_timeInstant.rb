# ISO <<Class>> TimeInstant
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-12-01 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-04 original script.

require_relative 'class_gmlIdentifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

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
                     s = hInstant[:description]
                     if !s.nil?
                        @xml.tag!('gml:description', s)
                     elsif @hResponseObj[:writerShowTags]
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
