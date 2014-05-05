# unpack GeoJSON properties
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-04-29 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_temporalElement'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_verticalElement'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_responsibleParty'

module AdiwgV1GeoProperties

	def self.unpack(hGeoProps, intElement)

		# set element extent - (default true)
		intElement[:elementIncludeData] = true
		if hGeoProps.has_key?('includesData')
			if !hGeoProps['includesData']
				intElement[:elementIncludeData] = false
			end
		end

		# set element feature name
		if hGeoProps.has_key?('featureName')
			s = hGeoProps['featureName']
			if s != ''
				intElement[:elementName] = s
			end
		end

		# set element description
		if hGeoProps.has_key?('description')
			s = hGeoProps['description']
			if s != ''
				intElement[:elementDescription] = s
			end
		end

		# set temporal information
		if hGeoProps.has_key?('temporalElement')
			hTempEle = hGeoProps['temporalElement']
			unless hTempEle.empty?
				intElement[:temporalElement] = AdiwgV1TemporalElement.unpack(hTempEle)
			end
		end

		# set vertical information
		if hGeoProps.has_key?('verticalElement')
			aVertEle = hGeoProps['verticalElement']
			unless aVertEle.empty?
				aVertEle.each do |hVertEle|
					intElement[:verticalElement] << AdiwgV1VerticalElement.unpack(hVertEle)
				end
			end
		end

		# set other assigned IDs
		if hGeoProps.has_key?('assignedId')
			aAssignId = hGeoProps['assignedId']
			unless aAssignId.empty?
				aAssignId.each do |hAssignId|
					intElement[:elementIdentifiers] << AdiwgV1ResponsibleParty.unpack(hAssignId)
				end
			end
		end

		# set feature scope
		if hGeoProps.has_key?('featureScope')
			s = hGeoProps['featureScope']
			if s != ''
				intElement[:elementScope] = s
			end
		end

		# set feature acquisition methodology
		if hGeoProps.has_key?('featureAcquisitionMethod')
			s = hGeoProps['featureAcquisitionMethod']
			if s != ''
				intElement[:elementAcquisition] = s
			end
		end

	end

end
