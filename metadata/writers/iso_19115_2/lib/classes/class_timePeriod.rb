# ISO <<Class>> TimePeriod
# writer output in XML

# History:
# 	Stan Smith 2013-11-04 original script

require 'builder'
require Rails.root + 'metadata/internal/module_dateTimeFun'

class TimePeriod

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hTempP)

		timeID = hTempP[:timeID]
		if timeID.nil?
			$idCount = $idCount.succ
			timeID = 'timePeriod' + $idCount
		end

		@xml.tag!('gml:TimePeriod',{'gml:id'=>timeID}) do

			# time period - description
			s = hTempP[:description]
			if !s.nil?
				@xml.tag!('gml:description',s)
			elsif $showEmpty
				@xml.tag!('gml:description')
			end

			# time period - begin position
			hDateTime = hTempP[:beginTime]
			timeInstant = hDateTime[:dateTime]
			timeResolution = hDateTime[:dateResolution]
			dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(timeInstant,timeResolution)
			@xml.tag!('gml:beginPosition',dateStr)

			# time period - begin position
			hDateTime = hTempP[:endTime]
			timeInstant = hDateTime[:dateTime]
			timeResolution = hDateTime[:dateResolution]
			dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(timeInstant,timeResolution)
			@xml.tag!('gml:endPosition',dateStr)

		end

	end

end


