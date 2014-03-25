# unpack legal constraint
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-14 original script
# 	Stan Smith 2013-11-27 modified to process a single legal constraint

require Rails.root + 'metadata/internal/internal_metadata_obj'

module AdiwgV1LegalConstraints

	def self.unpack(hLegalCon)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		hIntCon = intMetadataClass.newLegalConstraint

		# legal constraint - access code
		if hLegalCon.has_key?('accessConstraints')
			aAccCodes = hLegalCon['accessConstraints']
			unless aAccCodes.empty?
				hIntCon[:accessCodes] = aAccCodes
			end
		end

		# legal constraint - use code
		if hLegalCon.has_key?('useConstraints')
			aUseCodes = hLegalCon['useConstraints']
			unless aUseCodes.empty?
				hIntCon[:useCodes] = aUseCodes
			end
		end

		# legal constraint - other constraints
		if hLegalCon.has_key?('otherConstraints')
			aOtherCons = hLegalCon['otherConstraints']
			unless aOtherCons.empty?
				hIntCon[:otherCons] = aOtherCons
			end
		end

		return hIntCon

	end

end
