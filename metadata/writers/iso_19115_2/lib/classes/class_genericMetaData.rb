# ISO <<Class>> GenericMetaData
# writer output in XML
# generic metadata only supports ...
	# time instant
	# time period

# History:
# 	Stan Smith 2013-11-04 original script

require 'builder'
require Rails.root + 'metadata/internal/module_dateTimeFun'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_timeInstant'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_timePeriod'

class GenericMetaData

	def initialize(xml)
		@xml = xml
	end

	def writeXML(aTempExt)

		# classes used
		timeIClass = TimeInstant.new(@xml)
		timePClass = TimePeriod.new(@xml)

		@xml.tag!('gml:GenericMetaData') do

			aTempExt.each do |hTempExt|

				# metadata - data
				hTimeD = hTempExt[:date]
				unless hTimeD.empty?
					date = hTimeD[:dateTime]
					dateResolution = hTimeD[:dateResolution]
					s = AdiwgDateTimeFun.stringDateFromDateTime(date, dateResolution)
					if s != 'ERROR'
						@xml.tag!('gco:Date', s)
					end
				end

				# metadata - time instant
				hTimeI = hTempExt[:timeInstant]
				unless hTimeI.empty?
					timeIClass.writeXML(hTimeI)
				end

				# metadata - time period
				hTimeP = hTempExt[:timePeriod]
				unless hTimeP.empty?
					timePClass.writeXML(hTimeP)
				end

			end

		end

	end

end


