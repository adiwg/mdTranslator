# ISO <<Class>> MD_Keyword
# writer output in XML

# History:
# 	Stan Smith 2013-09-18 original script

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/codelists/code_keywordType'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_citation'

class MD_Keywords

	def initialize(xml)
		@xml = xml
	end

	def writeXML(dKeyword)

		# classes used
		citationClass = CI_Citation.new(@xml)
		keywordCode = MD_KeywordTypeCode.new(@xml)

		@xml.tag!('gmd:MD_Keywords') do

			# keywords - keyword - required
			aKeywords = dKeyword[:keyword]
			if aKeywords.empty?
				@xml.tag!('gmd:keyword', {'gco:nilReason' => 'missing'})
			else
				aKeywords.each do |keyword|
					@xml.tag!('gmd:keyword') do
						@xml.tag!('gco:CharacterString', keyword)
					end
				end
			end

			# keywords - type - MD_KeywordTypeCode
			s = dKeyword[:keywordType]
			if !s.nil?
				@xml.tag!('gmd:type') do
					keywordCode.writeXML(s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:type')
			end

			hKeyCitation = dKeyword[:keyTheCitation]
			keyLink = dKeyword[:keyTheLink]
			if !hKeyCitation.empty?

				# thesaurus - web link - attribute optional
				attributes = {}
				attributes['xlink:href'] = keyLink if keyLink
				@xml.tag!('gmd:thesaurusName', attributes) do

					# thesaurus - citation - CI_Citation (w/o responsible party)
					citationClass.writeXML(hKeyCitation)

				end

			elsif $showEmpty
				@xml.tag!('gmd:thesaurusName')
			end

		end

	end

end


