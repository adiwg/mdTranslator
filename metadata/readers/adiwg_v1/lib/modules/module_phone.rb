# unpack phone
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-16 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'

module AdiwgV1Phone

	def self.unpack(hPhone)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intPhone = intMetadataClass.newPhone

		# phone - name
		if hPhone.has_key?('phoneName')
			s = hPhone['phoneName']
			unless s.nil?
				intPhone[:phoneName] = s
			end
		end

		# phone - number
		if hPhone.has_key?('phoneNumber')
			s = hPhone['phoneNumber']
			unless s.nil?
				intPhone[:phoneNumber] = s
			end
		end

		return intPhone

	end

end