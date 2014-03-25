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


require Rails.root + 'metadataxx/internal/internal_metadata_obj'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_dateTime'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_timeInstant'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_timePeriod'

module AdiwgV1TemporalElement

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
					intTempEle[:date] = AdiwgV1DateTime.unpack(s)
					aIntTempElements << intTempEle
				end
			end
		end

		# temporal element - time instant
		if hTempElement.has_key?('timeInstant')
			aTimeInst = hTempElement['timeInstant']
			unless aTimeInst.empty?
				aTimeInst.each do |hTimeInst|

					# time instant will only be inserted if time position provided
					if hTimeInst.has_key?('timePosition')
						s = hTimeInst['timePosition']
						if s != ''
							intTempEle = intMetadataClass.newTemporalElement
							intTempEle[:timeInstant] = AdiwgV1TimeInstant.unpack(hTimeInst)
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
					intTempEle[:timePeriod] = AdiwgV1TimePeriod.unpack(hTimePeriod)
					aIntTempElements << intTempEle
				end
			end
		end

		return aIntTempElements

	end

end
