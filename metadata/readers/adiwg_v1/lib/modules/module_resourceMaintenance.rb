# unpack resource maintenance
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-10-31 original script
# 	Stan Smith 2013-12-18 made note an array
# 	Stan Smith 2013-12-18 added contact

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_responsibleParty'

module AdiwgV1ResourceMaintenance

	def self.unpack(hResource)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intResMaint = intMetadataClass.newResourceMaint

		# resource maintenance - frequency code
		if hResource.has_key?('maintFreq')
			s = hResource['maintFreq']
			if s != ''
				intResMaint[:maintFreq] = s
			end
		end

		# resource maintenance - maintenance note
		if hResource.has_key?('maintNote')
			aNotes = hResource['maintNote']
			unless aNotes.empty?
				intResMaint[:maintNotes] = aNotes
			end
		end

		# resource maintenance - contact
		if hResource.has_key?('maintContact')
			aContact = hResource['maintContact']
			unless aContact.empty?
				aContact.each do |hContact|
					intResMaint[:maintContacts] << AdiwgV1ResponsibleParty.unpack(hContact)
				end
			end
		end

		return intResMaint
	end

end