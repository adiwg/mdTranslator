# Writer - internal data structure to ISO 19110:2003

# History:
# 	Stan Smith 2014-12-01 original script

require 'builder'
require 'date'
require 'uuidtools'
require 'class_FCfeatureCatalogue'

$idCount = '_000'

class Iso19110Writer

	def initialize
	end

	def writeXML(internalObj)

		# create new XML document
		xml = Builder::XmlMarkup.new(indent: 3)
		metadataWriter = FC_FeatureCatalogue.new(xml)
		metadata = metadataWriter.writeXML(internalObj)

		return metadata
	end

end
