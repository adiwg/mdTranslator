# unpack resource identifier
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-05-28 original script
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_citation', $jsonVersionNum)
require ADIWG::Mdtranslator.reader_module('module_responsibleParty', $jsonVersionNum)
require ADIWG::Mdtranslator.reader_module('module_onlineResource', $jsonVersionNum)

module Adiwg_ResourceIdentifier

	def self.unpack(hResID)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intResID = intMetadataClass.newResourceId

		# resource identifier - identifier
		if hResID.has_key?('identifier')
			s = hResID['identifier']
			if s != ''
				intResID[:identifier] = s
			end
		end

		# resource identifier - authority (expressed as a citation)
		intResID[:identifierCitation] =  Adiwg_Citation.unpack(hResID)

		return intResID

	end

end