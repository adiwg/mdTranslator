# unpack voucher
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-21 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_responsibleParty'

module AdiwgV1Voucher

	def self.unpack(hVoucher)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intTaxVoucher = intMetadataClass.newTaxonVoucher

		# taxonomy voucher - specimen
		if hVoucher.has_key?('specimen')
			s = hVoucher['specimen']
			if s != ''
				intTaxVoucher[:specimen] = s
			end
		end

		# taxonomy - repository - responsible party
		if hVoucher.has_key?('repository')
			hRepository = hVoucher['repository']
			unless hRepository.empty?
				intTaxVoucher[:repository] = AdiwgV1ResponsibleParty.unpack(hRepository)
			end
		end

		return intTaxVoucher

	end

end
