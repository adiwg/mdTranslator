# Writer - internal data structure to ISO 19115-2:2009

# History:
# 	Stan Smith 2013-08-10 original script

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_metadata'

class Iso19115_2

	def initialize
	end

	def writeXML(internalObj)

		# create new XML document
		xml = Builder::XmlMarkup.new(indent: 3)

		iso19115_2 = MI_Metadata.new(internalObj)
		iso19115_2.writeXML(xml)

		return xml
	end
end
