# unpack process step
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-26 original script

require Rails.root + 'metadataxx/internal/internal_metadata_obj'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_responsibleParty'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_dateTime'

module AdiwgV1ProcessStep

	def self.unpack(hProcStep)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intDataPStep = intMetadataClass.newDataProcessStep

		# process step - step ID
		if hProcStep.has_key?('stepId')
			s = hProcStep['stepId']
			if s != ''
				intDataPStep[:stepID] = s
			end
		end

		# process step - description
		if hProcStep.has_key?('description')
			s = hProcStep['description']
			if s != ''
				intDataPStep[:stepDescription] = s
			end
		end

		# process step - rationale
		if hProcStep.has_key?('rationale')
			s = hProcStep['rationale']
			if s != ''
				intDataPStep[:stepRationale] = s
			end
		end

		# process step - dateTime
		if hProcStep.has_key?('dateTime')
			s = hProcStep['dateTime']
			if s != ''
				intDataPStep[:stepDateTime] = AdiwgV1DateTime.unpack(s)
			end
		end

		# process step - step processors
		if hProcStep.has_key?('processor')
			aProcessors = hProcStep['processor']
			unless aProcessors.empty?
				aProcessors.each do |processor|
					intDataPStep[:stepProcessors] << AdiwgV1ResponsibleParty.unpack(processor)
				end
			end
		end

		return intDataPStep
	end

end