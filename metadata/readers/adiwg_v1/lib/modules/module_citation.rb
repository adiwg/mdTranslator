# unpack citation
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-08-26 original script
#   Stan Smith 2014-04-25 modified to support json schema 0.3.0

require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_dateTime'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_responsibleParty'
require Rails.root + 'metadata/readers/adiwg_v1/lib/modules/module_onlineResource'

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
				aCitDates.each do |hCitDate|
					if hCitDate.has_key?('date')
						s = hCitDate['date']
						if s != ''
							intDateTime = AdiwgV1DateTime.unpack(s)
							if hCitDate.has_key?('dateType')
								s = hCitDate['dateType']
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
		if hCitation.has_key?('responsibleParty')
			aRParty = hCitation['responsibleParty']
			unless aRParty.empty?
				aRParty.each do |hRParty|
					intCitation[:citResponsibleParty] << AdiwgV1ResponsibleParty.unpack(hRParty)
				end
			end
		end

		# citation - presentation form
		if hCitation.has_key?('presentationForm')
			aPForms = hCitation['presentationForm']
			unless aPForms.empty?
				aPForms.each do |pForm|
					intCitation[:citResourceForms] << pForm
				end
			end
		end

		# citation - additional identifiers
		if hCitation.has_key?('additionalIdentifier')
			hAddIds = hCitation['additionalIdentifier']

			# citation - doi
			if hAddIds.has_key?('doi')
				s = hAddIds['doi']
				if s != ''
					intCitation[:citDOI] = s
				end
			end

			# citation - ISBN
			if hAddIds.has_key?('isbn')
				s = hAddIds['isbn']
				if s != ''
					intCitation[:citISBN]  = s
				end
			end

			# citation - ISSN
			if hAddIds.has_key?('issn')
				s = hAddIds['issn']
				if s != ''
					intCitation[:citISSN]  = s
				end
			end
		end

		# citation - online resources
		if hCitation.has_key?('onlineResource')
			aOlRes = hCitation['onlineResource']
			aOlRes.each do |hOlRes|
				unless hOlRes.empty?
					intCitation[:citOlResources] << AdiwgV1OnlineResource.unpack(hOlRes)
				end
			end
		end

		return intCitation
	end

end
