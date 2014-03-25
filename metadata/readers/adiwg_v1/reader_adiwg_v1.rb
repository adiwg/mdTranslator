# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-09 original script
# 	Stan Smith 2013-08-19 split out contacts to module_contacts
# 	Stan Smith 2013-08-23 split out metadata to module_metadata

require 'json'
require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_contacts'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_metadata'

class ReaderAdiwgV1

	def initialize
	end

	def unpack(jsonObj)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new

		# create new internal metadata container for the reader
		# this is a empty copy of the ADIwg internal metadata format
		intBase = intMetadataClass.newBase

		# convert the received JSON to a Ruby hash
		hashObj = JSON.parse(jsonObj)

		# load array of contacts from the hash object
			# the contacts array supports using a shorthand reference to a
		 	# contact in the metadata sections
		if hashObj.has_key?('contacts')
			contacts = hashObj['contacts']
			intBase[:contacts] = AdiwgV1Contacts.unpack(contacts)
		end

		# load metadata from the hash object
		if hashObj.has_key?('metadata')
			metadata = hashObj['metadata']
			intBase[:metadata] = AdiwgV1Metadata.unpack(metadata)
		end

		# return ADIwg internal container
		return intBase
	end

end