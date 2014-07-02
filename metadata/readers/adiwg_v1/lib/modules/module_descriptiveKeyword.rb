# unpack descriptive keyword
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-09-18 original script
# 	Stan Smith 2013-11-27 modified to process single keyword collection

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_citation'

module Adiwg_DescriptiveKeyword

	def self.unpack(hDesKeyword)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intKeyword = intMetadataClass.newKeyword

		# descriptive keyword - keyword array
		if hDesKeyword.has_key?('keyword')
			aKeywords = hDesKeyword['keyword']
			aKeywords.each do |keyword|
				intKeyword[:keyword] << keyword
			end
		end

		# descriptive keyword - keyType
		if hDesKeyword.has_key?('keywordType')
			s = hDesKeyword['keywordType']
			if s != ''
				intKeyword[:keywordType] = s
			end
		end

		# descriptive keyword - thesaurus
		if hDesKeyword.has_key?('thesaurus')
			keyThesaurus = hDesKeyword['thesaurus']
			if keyThesaurus != ''

				# thesaurus - link
				s = keyThesaurus['thesaurusLink']
				if s != ''
					intKeyword[:keyTheLink] = s
				end

				# thesaurus - citation
				hCitation = keyThesaurus['citation']
				unless hCitation.empty?
					intKeyword[:keyTheCitation] = Adiwg_Citation.unpack(hCitation)
				end

			end

		end

		return intKeyword
	end

end
