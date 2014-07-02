# unpack time instant
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-11 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_dateTime'

module Adiwg_TimeInstant

	def self.unpack(hTimeInst)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new

		# time instant
		intTimeInst = intMetadataClass.newTimeInstant

		if hTimeInst.has_key?('id')
			s = hTimeInst['id']
			if s != ''
				intTimeInst[:timeID] = s
			end
		end

		if hTimeInst.has_key?('description')
			s = hTimeInst['description']
			if s != ''
				intTimeInst[:description] = s
			end
		end

		# time instant will only be inserted if time position provided
		if hTimeInst.has_key?('timePosition')
			s = hTimeInst['timePosition']
			if s != ''
				intTimeInst[:timePosition] = Adiwg_DateTime.unpack(s)
			end
		end

		return intTimeInst
	end

end