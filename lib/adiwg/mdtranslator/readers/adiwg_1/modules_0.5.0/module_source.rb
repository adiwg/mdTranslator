# unpack source
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-26 original script
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_citation', $jsonVersion)
require ADIWG::Mdtranslator.reader_module('module_processStep', $jsonVersion)

module Adiwg_Source

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
				intDataSource[:sourceCitation] = Adiwg_Citation.unpack(hCitation)
			end
		end

		# source - data sources
		if hSource.has_key?('processStep')
			aSourceSteps = hSource['processStep']
			unless aSourceSteps.empty?
				aSourceSteps.each do |hStep|
					intDataSource[:sourceSteps] << Adiwg_ProcessStep.unpack(hStep)
				end
			end
		end

		return intDataSource
	end

end