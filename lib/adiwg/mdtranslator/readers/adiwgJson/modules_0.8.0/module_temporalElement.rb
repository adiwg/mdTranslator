# unpack temporal element
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-14 original script
# 	Stan Smith 2013-11-15
# 		. revised to handle temporal elements for both feature
#		  properties and extents
# 		. multiple temporal elements are allowed per extent
# 		. each definition will create a new element
# 	Stan Smith 2013-12-11 modified to handle single temporal element
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_dateTime', $response[:readerVersionFound])
require ADIWG::Mdtranslator.reader_module('module_timeInstant', $response[:readerVersionFound])
require ADIWG::Mdtranslator.reader_module('module_timePeriod', $response[:readerVersionFound])

module Adiwg_TemporalElement

	def self.unpack(hTempElement)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		aIntTempElements = Array.new

		# temporal element - date
		if hTempElement.has_key?('date')
			aDates = hTempElement['date']
			unless aDates.empty?
				aDates.each do |s|
					intTempEle = intMetadataClass.newTemporalElement
					intTempEle[:date] = Adiwg_DateTime.unpack(s)
					aIntTempElements << intTempEle
				end
			end
		end

		# temporal element - time instant
		if hTempElement.has_key?('timeInstant')
			aTimeInst = hTempElement['timeInstant']
			unless aTimeInst.empty?
				aTimeInst.each do |hTimeInst|
					if hTimeInst.has_key?('timePosition')
						s = hTimeInst['timePosition']
						if s != ''
							intTempEle = intMetadataClass.newTemporalElement
							intTempEle[:timeInstant] = Adiwg_TimeInstant.unpack(hTimeInst)
							aIntTempElements << intTempEle
						end
					end
				end
			end
		end

		# temporal element - time period
		if hTempElement.has_key?('timePeriod')
			aTimePeriod = hTempElement['timePeriod']
			unless aTimePeriod.empty?
				aTimePeriod.each do |hTimePeriod|
					intTempEle = intMetadataClass.newTemporalElement
					intTempEle[:timePeriod] = Adiwg_TimePeriod.unpack(hTimePeriod)
					aIntTempElements << intTempEle
				end
			end
		end

		return aIntTempElements

	end

end
