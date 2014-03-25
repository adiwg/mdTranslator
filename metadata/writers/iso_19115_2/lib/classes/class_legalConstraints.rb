# ISO <<Class>> MD_LegalConstraints
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script

require 'builder'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/codelists/code_restriction'

class MD_LegalConstraints

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hLegalCons)

		# classes used
		restrictionCode = MD_RestrictionCode.new(@xml)

		@xml.tag!('gmd:MD_LegalConstraints') do

			# legal constraints - access constraints
			aAccessCodes = hLegalCons[:accessCodes]
			if !aAccessCodes.empty?
				aAccessCodes.each do |code|
					@xml.tag!('gmd:accessConstraints') do
						restrictionCode.writeXML(code)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:accessConstraints')
			end

			# legal constraints - use constraints
			aUseCodes = hLegalCons[:useCodes]
			if !aUseCodes.empty?
				aUseCodes.each do |code|
					@xml.tag!('gmd:useConstraints') do
						restrictionCode.writeXML(code)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:useConstraints')
			end

			# legal constraints - other constraints
			aOtherCons = hLegalCons[:otherCons]
			if !aOtherCons.empty?
				aOtherCons.each do |con|
					@xml.tag!('gmd:otherConstraints') do
						@xml.tag!('gco:CharacterString',con)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:otherConstraints')
			end

		end

	end

end