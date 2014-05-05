# unpack taxonomy
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-20 original script
#   Stan Smith 2014-05-02 fixed assignment problem with taxon general scope
#   Stan Smith 2014-05-02 fixed assignment problem with taxonomic procedures

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_citation'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_responsibleParty'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_voucher'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_taxonClass'

module AdiwgV1Taxonomy

	def self.unpack(hTaxonomy)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intTaxSys = intMetadataClass.newTaxonSystem

		# taxonomy - taxonomy class system - citation
		if hTaxonomy.has_key?('classificationSystem')
			aClassSys = hTaxonomy['classificationSystem']
			unless aClassSys.empty?
				aClassSys.each do |hCitation|
					intTaxSys[:taxClassSys] << AdiwgV1Citation.unpack(hCitation)
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
					intTaxSys[:taxObservers] << AdiwgV1ResponsibleParty.unpack(observer)
				end
			end
		end

		# taxonomy - taxonomic procedures
		if hTaxonomy.has_key?('taxonomicProcedures')
			s = hTaxonomy['taxonomicProcedures']
			if s != ''
				intTaxSys[:taxIdProcedures] = s
			end
		end

		# taxonomy - voucher
		if hTaxonomy.has_key?('voucher')
			hVoucher = hTaxonomy['voucher']
			unless hVoucher.empty?
				intTaxSys[:taxVoucher] = AdiwgV1Voucher.unpack(hVoucher)
			end
		end

		# taxonomy - classification (recursive)
		if hTaxonomy.has_key?('taxonClass')
			aTaxClass = hTaxonomy['taxonClass']
			unless aTaxClass.empty?
				aTaxClass.each do |hTaxClass|
					intTaxSys[:taxClasses] << AdiwgV1TaxonCl.unpack(hTaxClass)
				end
			end
		end

		return intTaxSys
	end

end
