# unpack phone
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-16 original script
#   Stan Smith 2014-05-14 combine phone service types

require Rails.root + 'metadata/internal/internal_metadata_obj'

module AdiwgV1Phone

	def self.unpack(hPhone)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		aPhones = Array.new

		# create a separate phone for each phone service type
		# if service is missing, default service to 'voice'
		if hPhone.has_key?('service')
			aService = hPhone['service']
		else
			aService = ['voice']
		end

		if aService.empty?
			aService = ['voice']
		end

		# if service is nil, default service to 'voice'
		aService.each do |phService|
			intPhone = intMetadataClass.newPhone

			# phone - service
			intPhone[:phoneServiceType] = phService

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

			aPhones << intPhone

		end

		return aPhones

	end

end