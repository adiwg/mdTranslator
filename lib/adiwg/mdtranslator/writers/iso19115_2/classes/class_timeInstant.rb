# ISO <<Class>> TimeInstant
# writer output in XML

# History:
# 	Stan Smith 2013-11-04 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'module_dateTimeFun'

class TimeInstant

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hTempI)

		timeID = hTempI[:timeID]
		if timeID.nil?
			$idCount = $idCount.succ
			timeID = 'timeInstant' + $idCount
		end

		@xml.tag!('gml:TimeInstant',{'gml:id'=>timeID}) do

			# time instant - description
			s = hTempI[:description]
			if !s.nil?
				@xml.tag!('gml:description',s)
			elsif $showAllTags
				@xml.tag!('gml:description')
			end

			# time instant - time position
			hDateTime = hTempI[:timePosition]
			timeInstant = hDateTime[:dateTime]
			timeResolution = hDateTime[:dateResolution]
			dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(timeInstant,timeResolution)
			@xml.tag!('gml:timePosition',dateStr)

		end

	end

end


