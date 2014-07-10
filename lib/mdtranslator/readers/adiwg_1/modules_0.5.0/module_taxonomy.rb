# unpack taxonomy
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-20 original script
#   Stan Smith 2014-05-02 fixed assignment problem with taxon general scope
#   Stan Smith 2014-05-02 fixed assignment problem with taxonomic procedures
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module

require Mdtranslator.reader_module('module_citation', $jsonVersion)
require Mdtranslator.reader_module('module_responsibleParty', $jsonVersion)
require Mdtranslator.reader_module('module_voucher', $jsonVersion)
require Mdtranslator.reader_module('module_taxonClass', $jsonVersion)

module Adiwg_Taxonomy

	def self.unpack(hTaxonomy)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intTaxSys = intMetadataClass.newTaxonSystem

		# taxonomy - taxonomy class system - citation
		if hTaxonomy.has_key?('classificationSystem')
			aClassSys = hTaxonomy['classificationSystem']
			unless aClassSys.empty?
				aClassSys.each do |hCitation|
					intTaxSys[:taxClassSys] << Adiwg_Citation.unpack(hCitation)
				end
			end
		end

		# taxonomy - general scope
		if hTaxonomy.has_key?('taxonGeneralScope')
			s = hTaxonomy['taxonGeneralScope']
			if s != ''
				intTaxSys[:taxGeneralScope] = s
			end
		end

		# taxonomy - ID reference system
		# not supported in JSON schema (defaulted to 'unknown')

		# taxonomy - observers - responsible party
		if hTaxonomy.has_key?('observer')
			aObservers = hTaxonomy['observer']
			unless aObservers.empty?
				aObservers.each do |observer|
					intTaxSys[:taxObservers] << Adiwg_ResponsibleParty.unpack(observer)
				end
			end
		end

		# taxonomy - taxonomic procedures
		if hTaxonomy.has_key?('taxonomicProcedure')
			s = hTaxonomy['taxonomicProcedure']
			if s != ''
				intTaxSys[:taxIdProcedures] = s
			end
		end

		# taxonomy - voucher
		if hTaxonomy.has_key?('voucher')
			hVoucher = hTaxonomy['voucher']
			unless hVoucher.empty?
				intTaxSys[:taxVoucher] = Adiwg_Voucher.unpack(hVoucher)
			end
		end

		# taxonomy - classification (recursive)
		if hTaxonomy.has_key?('taxonClass')
			aTaxClass = hTaxonomy['taxonClass']
			unless aTaxClass.empty?
				aTaxClass.each do |hTaxClass|
					intTaxSys[:taxClasses] << Adiwg_TaxonCl.unpack(hTaxClass)
				end
			end
		end

		return intTaxSys
	end

end
