# unpack resource maintenance
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-10-31 original script
# 	Stan Smith 2013-12-18 made note an array
# 	Stan Smith 2013-12-18 added contact
#   Stan Smith 2014-04-24 modified for json schema 0.3.0
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_responsibleParty', $response[:readerVersionFound])

module Adiwg_ResourceMaintenance

	def self.unpack(hResource)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intResMaint = intMetadataClass.newResourceMaint

		# resource maintenance - frequency code
		if hResource.has_key?('maintenanceFrequency')
			s = hResource['maintenanceFrequency']
			if s != ''
				intResMaint[:maintFreq] = s
			end
		end

		# resource maintenance - maintenance note
		if hResource.has_key?('maintenanceNote')
			aNotes = hResource['maintenanceNote']
			unless aNotes.empty?
				intResMaint[:maintNotes] = aNotes
			end
		end

		# resource maintenance - contact
		if hResource.has_key?('maintenanceContact')
			aContact = hResource['maintenanceContact']
			unless aContact.empty?
				aContact.each do |hContact|
					intResMaint[:maintContacts] << Adiwg_ResponsibleParty.unpack(hContact)
				end
			end
		end

		return intResMaint
	end

end