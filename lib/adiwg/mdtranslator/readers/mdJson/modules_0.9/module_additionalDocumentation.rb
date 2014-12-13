# unpack additional doucmentation
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-11-06 original script

require ADIWG::Mdtranslator.reader_module('module_citation', $response[:readerVersionUsed])

module Md_AdditionalDocumentation

	def self.unpack(hAddDoc)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intAddDoc = intMetadataClass.newAssociatedResource

		# associated resource - resource type
		if hAddDoc.has_key?('resourceType')
			s = hAddDoc['resourceType']
			if s != ''
				intAddDoc[:resourceType] = s
			end
		end

		# associated resource - resource citation
		if hAddDoc.has_key?('citation')
			hCitation = hAddDoc['citation']
			unless hCitation.empty?
				intAddDoc[:citation] = Md_Citation.unpack(hCitation)
			end
		end

		return intAddDoc
	end

end
