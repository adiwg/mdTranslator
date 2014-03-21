# unpack source
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-26 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_citation'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_processStep'

module AdiwgV1Source

	def self.unpack(hSource)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intDataSource = intMetadataClass.newDataSource

		# source - description
		if hSource.has_key?('description')
			s = hSource['description']
			if s != ''
				intDataSource[:sourceDescription] = s
			end
		end

		# source - citation
		if hSource.has_key?('citation')
			hCitation = hSource['citation']
			unless hCitation.empty?
				intDataSource[:sourceCitation] = AdiwgV1Citation.unpack(hCitation)
			end
		end

		# source - data sources
		if hSource.has_key?('processStep')
			aSourceSteps = hSource['processStep']
			unless aSourceSteps.empty?
				aSourceSteps.each do |hStep|
					intDataSource[:sourceSteps] << AdiwgV1ProcessStep.unpack(hStep)
				end
			end
		end

		return intDataSource
	end

end