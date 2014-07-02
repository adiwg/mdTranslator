# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-09 original script
# 	Stan Smith 2013-08-19 split out contacts to module_contacts
# 	Stan Smith 2013-08-23 split out metadata to module_metadata
#	Stan Smith 2014-04-23 add json schema version to internal object
#   Stan Smith 2014-06-05 capture an test json version

$jsonVersion = 'unknown'

require 'json'
require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_contacts'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_metadata'

class Adiwg_Reader

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
		if hashObj.has_key?('version')
			hVersion = hashObj['version']
			intBase[:jsonVersion] = hVersion

			# name must be 'adiwgJSON' to proceed
			if hVersion.has_key?('name')
				s = hVersion['name']
				if s != 'adiwgJSON'
					return false
				end
			end

			# capture version to use in directory traversing
			# must have valid version to proceed
			if hVersion.has_key?('version')
				s = hVersion['version']
				if !s.nil?
					$jsonVersion = s
				end
			end
			if $jsonVersion == 'unknown'
				return false
			end

		end

		# contact
		# load the array of contacts from the json object
			# the contacts array uses a local id to reference the
		 	# contact in the array from elsewhere in the json metadata
		if hashObj.has_key?('contact')
			aContacts = hashObj['contact']
			aContacts.each do |hContact|
				unless hContact.empty?
					intBase[:contacts] << Adiwg_Contact.unpack(hContact)
				end
			end
		end

		# add default contacts
		intBase[:contacts].concat(Adiwg_Contact.setDefaultContacts)

		# metadata
		# load metadata from the hash object
		if hashObj.has_key?('metadata')
			hMetadata = hashObj['metadata']
			intBase[:metadata] = Adiwg_Metadata.unpack(hMetadata)
		end

		# return ADIwg internal container
		return intBase

	end

end