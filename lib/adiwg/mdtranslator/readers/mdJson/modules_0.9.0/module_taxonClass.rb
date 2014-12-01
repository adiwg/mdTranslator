# unpack taxonomy class
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-21 original script

module Md_TaxonCl

	def self.unpack(hTaxClass)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new

		intTaxClass = intMetadataClass.newTaxonClass

		# taxonomic classification - common name
		if hTaxClass.has_key?('common')
			s = hTaxClass['common']
			if s != ''
				intTaxClass[:commonName] = s
			end
		end

		# taxonomic classification - rank
		if hTaxClass.has_key?('taxonRank')
			s = hTaxClass['taxonRank']
			if s != ''
				intTaxClass[:taxRankName] = s
			end
		end

		# taxonomic classification - value
		if hTaxClass.has_key?('taxonValue')
			s = hTaxClass['taxonValue']
			if s != ''
				intTaxClass[:taxRankValue] = s
			end
		end

		return intTaxClass
	end

end
