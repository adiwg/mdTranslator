# unpack voucher
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-21 original script
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module

require Mdtranslator.reader_module('module_responsibleParty', $jsonVersion)

module Adiwg_Voucher

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
				intTaxVoucher[:repository] = Adiwg_ResponsibleParty.unpack(hRepository)
			end
		end

		return intTaxVoucher

	end

end
