# ISO <<Class>> MD_Identifier
# writer
# output for ISO 19115-2 XML

# History:
# 	Stan Smith 2014-05-16 original script
#   Stan Smith 2014-05-28 revised for json schema 0.5.0
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'class_citation'

class MD_Identifier

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hResID)

		# the authority for the identifier is a citation block

		# classes used in MD_Metadata
		citationClass = CI_Citation.new(@xml)

		@xml.tag!('gmd:MD_Identifier') do

			# identifier - authority
			hCitation = hResID[:identifierCitation]
			if !hCitation.empty?
				@xml.tag!('gmd:authority') do
					citationClass.writeXML(hCitation)
				end
			elsif $showAllTags
				@xml.tag!('gmd:authority')
			end

			# identity - code - required
			s = hResID[:identifier]
			if !s.nil?
				@xml.tag!('gmd:code') do
					@xml.tag!('gco:CharacterString', s)
				end
			elsif $showAllTags
				@xml.tag!('gmd:code')
			end

		end

	end

end