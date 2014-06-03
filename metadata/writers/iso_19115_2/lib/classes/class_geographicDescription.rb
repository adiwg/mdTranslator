# ISO <<Class>> EX_GeographicDescription
# writer output in XML

# History:
# 	Stan Smith 2013-06-03 original script

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_identifier'

class EX_GeographicDescription

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hElement)

		# classes used in MD_Metadata
		idClass = MD_Identifier.new(@xml)

		@xml.tag!('gmd:EX_GeographicDescription') do
			@xml.tag!('gmd:geographicIdentifier') do
				idClass.writeXML(hElement)
			end
		end

	end

end