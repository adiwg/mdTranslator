# unpack data quality
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-26 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_lineage'

module AdiwgV1DataQuality

	def self.unpack(hDataQual)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intDataQual = intMetadataClass.newDataQuality

		# data quality - scope
		if hDataQual.has_key?('scope')
			s = hDataQual['scope']
			if s != ''
				intDataQual[:dataScope] = s
			end
		end

		# data quality - report
		# on hold

		# data quality - lineage
		if hDataQual.has_key?('lineage')
			hLineage = hDataQual['lineage']
			unless hLineage.empty?
				intDataQual[:dataLineage] = AdiwgV1Lineage.unpack(hLineage)
			end
		end

		return intDataQual
	end

end