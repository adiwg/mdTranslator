# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-09 original script
# 	Stan Smith 2013-08-19 split out contacts to module_contacts
# 	Stan Smith 2013-08-23 split out metadata to module_metadata
#	Stan Smith 2014-04-23 add json schema version to internal object
#   Stan Smith 2014-06-05 capture an test json version
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-07-08 moved json schema version testing to 'adiwg_1_get_version'
#   Stan Smith 2014-08-18 add json name/version to internal object
#   Stan Smith 2014-12-01 add data dictionary

require 'json'
require ADIWG::Mdtranslator.reader_module('module_contacts', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_metadata', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_dataDictionary', $response[:readerVersionUsed])

class AdiwgJsonReader

	def initialize
	end

	def unpack(jsonObj)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new

		# create new internal metadata container for the reader
		intBase = intMetadataClass.newBase

		# convert the received JSON to a Ruby hash
		hashObj = JSON.parse(jsonObj)

		# get json schema name and version
		if hashObj.has_key?('version')
			hVersion = hashObj['version']
		    unless hVersion.empty?
				if hVersion.has_key?('name')
					s = hVersion['name']
					if !s.nil?
						intBase[:jsonVersion][:name] = s
					end
				end
				if hVersion.has_key?('version')
					s = hVersion['version']
					if !s.nil?
						intBase[:jsonVersion][:version] = s
					end
				end
			end
		end

		# contact
		# load the array of contacts from the json object
		# ... the contacts array uses a local id to reference the
		# ... contact in the array from elsewhere in the json metadata
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

		# data dictionary
		if hashObj.has_key?('dataDictionary')
			hDictionary = hashObj['dataDictionary']
			intBase[:dataDictionary] = Adiwg_DataDictionary.unpack(hDictionary)
		end

		# return ADIwg internal container
		return intBase

	end

end