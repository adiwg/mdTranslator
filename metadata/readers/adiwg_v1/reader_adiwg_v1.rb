# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-09 original script
# 	Stan Smith 2013-08-19 split out contacts to module_contacts
# 	Stan Smith 2013-08-23 split out metadata to module_metadata
#	Stan Smith 2014-04-23 add json schema version to internal object

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
		intBase = intMetadataClass.newBase

		# convert the received JSON to a Ruby hash
		hashObj = JSON.parse(jsonObj)

		# jsonVersion
		# get json schema name and version
		if hashObj.has_key?('jsonVersion')
			intBase[:jsonVersion] = hashObj['jsonVersion']
		end

		# contact
		# load the array of contacts from the json object
			# the contacts array uses a local id to reference the
		 	# contact in the array from elsewhere in the json metadata
		if hashObj.has_key?('contact')
			aContacts = hashObj['contact']
			aContacts.each do |hContact|
				unless hContact.empty?
					intBase[:contacts] << AdiwgV1Contact.unpack(hContact)
				end
			end
		end

		# add default contacts
		intBase[:contacts].concat(AdiwgV1Contact.getDefaultContacts)

		# metadata
		# load metadata from the hash object
		if hashObj.has_key?('metadata')
			hMetadata = hashObj['metadata']
			intBase[:metadata] = AdiwgV1Metadata.unpack(hMetadata)
		end

		# return ADIwg internal container
		return intBase

	end

end