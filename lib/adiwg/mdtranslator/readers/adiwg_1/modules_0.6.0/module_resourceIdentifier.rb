# unpack resource identifier
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-05-28 original script
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-08-18 added type to identifier schema 0.6.0

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

		# resource identifier - identifier type
		if hResID.has_key?('type')
			s = hResID['type']
			if s != ''
				intResID[:identifierType] = s
			end
		end

		# resource identifier - authority (expressed as a citation)
		if hResID.has_key?('authority')
			hCitation = hResID['authority']
			unless hCitation.empty?
				intResID[:identifierCitation] =  Adiwg_Citation.unpack(hCitation)
			end
		end

		return intResID

	end

end