# unpack citation
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-26 original script

require Rails.root + 'metadataxx/internal/internal_metadata_obj'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_dateTime'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_responsibleParty'

module AdiwgV1Citation

	def self.unpack(hCitation)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intCitation = intMetadataClass.newCitation

		# citation - title
		if hCitation.has_key?('title')
			s = hCitation['title']
			if s != ''
				intCitation[:citTitle] = s
			end
		end

		# citation - date
		if hCitation.has_key?('date')
			aCitDates = hCitation['date']
			unless aCitDates.empty?
				aCitDates.each do |citDate|
					if citDate.has_key?('date')
						s = citDate['date']
						if s != ''
							intDateTime = AdiwgV1DateTime.unpack(s)

							if citDate.has_key?('dateType')
								s = citDate['dateType']
								if s != ''
									intDateTime[:dateType] = s
								end
							end

							intCitation[:citDate] << intDateTime
						end
					end
				end
			end
		end

		# citation - edition
		if hCitation.has_key?('edition')
			s = hCitation['edition']
			if s != ''
				intCitation[:citEdition]  = s
			end
		end

		# citation - responsible party
		if hCitation.has_key?('citedResponsibleParty')
			aRParty = hCitation['citedResponsibleParty']
			unless aRParty.empty?
				aRParty.each do |rParty|
					intCitation[:citResParty] << AdiwgV1ResponsibleParty.unpack(rParty)
				end
			end
		end

		# citation - presentation form
		if hCitation.has_key?('presentationForm')
			s = hCitation['presentationForm']
			if s != ''
				intCitation[:citForm]  = s
			end
		end

		# citation - ISBN
		if hCitation.has_key?('isbn')
			s = hCitation['isbn']
			if s != ''
				intCitation[:citISBN]  = s
			end
		end

		# citation - ISSN
		if hCitation.has_key?('issn')
			s = hCitation['issn']
			if s != ''
				intCitation[:citISSN]  = s
			end
		end

		return intCitation
	end

end
