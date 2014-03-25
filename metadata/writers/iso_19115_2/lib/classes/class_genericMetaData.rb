# ISO <<Class>> GenericMetaData
# writer output in XML
# generic metadataxx only supports ...
	# time instant
	# time period

# History:
# 	Stan Smith 2013-11-04 original script

require 'builder'
require Rails.root + 'metadataxx/internal/module_dateTimeFun'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_timeInstant'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_timePeriod'

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

				# metadataxx - date
				hTimeD = hTempExt[:date]
				unless hTimeD.empty?
					date = hTimeD[:dateTime]
					dateResolution = hTimeD[:dateResolution]
					s = AdiwgDateTimeFun.stringDateFromDateTime(date, dateResolution)
					if s != 'ERROR'
						@xml.tag!('gco:Date', s)
					end
				end

				# metadataxx - time instant
				hTimeI = hTempExt[:timeInstant]
				unless hTimeI.empty?
					timeIClass.writeXML(hTimeI)
				end

				# metadataxx - time period
				hTimeP = hTempExt[:timePeriod]
				unless hTimeP.empty?
					timePClass.writeXML(hTimeP)
				end

			end

		end

	end

end


