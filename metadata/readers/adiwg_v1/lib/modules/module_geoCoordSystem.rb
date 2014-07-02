# unpack GeoJSON properties
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-04-30 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'

module Adiwg_GeoCoordSystem

	def self.unpack(hGeoCrs, intElement)

		intMetadataClass = InternalMetadata.new
		intSRS = intMetadataClass.newSRS

		# get coordinate reference system
		# null crs will default to CRS84 in writer
		if hGeoCrs.has_key?('properties')
			hCRSProp = hGeoCrs['properties']

			if hCRSProp.has_key?('name')
				s = hCRSProp['name']
				if s != ''
					intSRS[:srsName] = s
				end
			end

			if hCRSProp.has_key?('href')
				s = hCRSProp['href']
				if s != ''
					intSRS[:srsHref] = s
				end
			end

			if hCRSProp.has_key?('type')
				s = hCRSProp['type']
				if s != ''
					intSRS[:srsType] = s
				end
			end

			intElement[:elementSrs] = intSRS

		end

	end

end
