# unpack lineage
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-26 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_processStep'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_source'

module AdiwgV1Lineage

	def self.unpack(hLineage)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intDataLine = intMetadataClass.newLineage

		# lineage - statement
		if hLineage.has_key?('statement')
			s = hLineage['statement']
			if s != ''
				intDataLine[:statement] = s
			end
		end

		# lineage - process steps
		if hLineage.has_key?('processStep')
			aProcSteps = hLineage['processStep']
			unless aProcSteps.empty?
				aProcSteps.each do |hProcStep|
					intDataLine[:processSteps] << AdiwgV1ProcessStep.unpack(hProcStep)
				end
			end
		end

		# lineage - data sources
		if hLineage.has_key?('source')
			aSources = hLineage['source']
			unless aSources.empty?
				aSources.each do |hSource|
					intDataLine[:dataSources] << AdiwgV1Source.unpack(hSource)
				end
			end
		end

		return intDataLine
	end

end