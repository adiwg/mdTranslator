# unpack resource formats
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-26 original script
# 	Stan Smith 2013-11-27 modified to process single resource format rather than array
#   Stan Smith 2014-04-28 changed attribute names

require Rails.root + 'metadata/internal/internal_metadata_obj'

module AdiwgV1ResourceFormat

	def self.unpack(hResFormat)

	# instance classes needed in script
	intMetadataClass = InternalMetadata.new
		rFormat = intMetadataClass.newResourceFormat

		# format - name
		if hResFormat.has_key?('formatName')
			s = hResFormat['formatName']
			if s != ''
				rFormat[:formatName] = s
			end
		end

		# format - version
		if hResFormat.has_key?('version')
			s = hResFormat['version']
			if s != ''
				rFormat[:formatVersion] = s
			end
		end

		return rFormat
	end

end
