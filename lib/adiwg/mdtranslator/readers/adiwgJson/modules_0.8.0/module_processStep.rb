# unpack process step
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-26 original script
#   Stan Smith 2014-07-03 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_responsibleParty', $response[:readerVersionFound])
require ADIWG::Mdtranslator.reader_module('module_dateTime', $response[:readerVersionFound])

module Adiwg_ProcessStep

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
				intDataPStep[:stepDateTime] = Adiwg_DateTime.unpack(s)
			end
		end

		# process step - step processors
		if hProcStep.has_key?('processor')
			aProcessors = hProcStep['processor']
			unless aProcessors.empty?
				aProcessors.each do |processor|
					intDataPStep[:stepProcessors] << Adiwg_ResponsibleParty.unpack(processor)
				end
			end
		end

		return intDataPStep
	end

end