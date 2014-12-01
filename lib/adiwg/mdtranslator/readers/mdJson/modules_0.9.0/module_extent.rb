# unpack extent
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-11-04 original script
# 	Stan Smith 2013-11-14 add temporal elements
# 	Stan Smith 2013-11-14 add vertical elements
# 	Stan Smith 2013-11-27 modified to process a single extent
# 	Stan Smith 2013-12-05 modified to for new temporalElement schema
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module

require ADIWG::Mdtranslator.reader_module('module_geographicElement', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_temporalElement', $response[:readerVersionUsed])
require ADIWG::Mdtranslator.reader_module('module_verticalElement', $response[:readerVersionUsed])

module Adiwg_Extent

	def self.unpack(hExtent)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intExtent = intMetadataClass.newExtent

		# extent - description
		if hExtent.has_key?('description')
			s = hExtent['description']
			if s != ''
				intExtent[:extDesc] = s
			end
		end

		# extent - geographic elements
		if hExtent.has_key?('geographicElement')
			aGeoElements = hExtent['geographicElement']
			unless aGeoElements.empty?
				intExtent[:extGeoElements] = Adiwg_GeographicElement.unpack(aGeoElements)
			end
		end

		# extent - temporal elements
		if hExtent.has_key?('temporalElement')
			hTempElement = hExtent['temporalElement']
			unless hTempElement.empty?
				intExtent[:extTempElements] = Adiwg_TemporalElement.unpack(hTempElement)
			end
		end

		# extent - vertical elements
		if hExtent.has_key?('verticalElement')
			aVertElements = hExtent['verticalElement']
			unless aVertElements.empty?
				aVertElements.each do |hVertElement|
					intExtent[:extVertElements] << Adiwg_VerticalElement.unpack(hVertElement)
				end
			end
		end

		return intExtent

	end

end
