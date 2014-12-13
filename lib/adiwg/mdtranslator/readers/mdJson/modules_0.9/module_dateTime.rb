# unpack dateTime
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-11 original script

require 'module_dateTimeFun'

module Md_DateTime

	def self.unpack(sDateTime)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new

		# dateTime
		intDateTime = intMetadataClass.newDateTime

		aDateTimeReturn = AdiwgDateTimeFun.dateTimeFromString(sDateTime)
		intDateTime[:dateTime] = aDateTimeReturn[0]
		intDateTime[:dateResolution] = aDateTimeReturn[1]

		return intDateTime

	end

end