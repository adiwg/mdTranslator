# ISO <<Class>> CI_Citation
# writer output in XML

# History:
# 	Stan Smith 2013-08-26 original script
# 	Stan Smith 2013-12-30 added ISBN, ISSN
#   Stan Smith 2014-05-16 modified for JSON schema 0.4.0
#   Stan Smith 2014-05-16 added MD_Identifier
#   Stan Smith 2014-05-28 modified for json schema 0.5.0

require 'builder'
require Rails.root + 'metadata/internal/internal_metadata_obj'
require Rails.root + 'metadata/writers/iso_19115_2/lib/codelists/code_presentationForm'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_responsibleParty'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_date'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_identifier'

class CI_Citation

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hCitation)

		# classes used in MD_Metadata
		intMetadataClass = InternalMetadata.new
		presFormClass = CI_PresentationFormCode.new(@xml)
		rPartyClass = CI_ResponsibleParty.new(@xml)
		dateClass = CI_Date.new(@xml)
		idClass = MD_Identifier.new(@xml)

		@xml.tag!('gmd:CI_Citation') do

			# citation - title - required
			s = hCitation[:citTitle]
			if s.nil?
				@xml.tag!('gmd:title',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:title') do
					@xml.tag!('gco:CharacterString',s)
				end
			end

			# citation - date - required
			aDate = hCitation[:citDate]
			if aDate.empty?
				@xml.tag!('gmd:date', {'gco:nilReason' => 'missing'})
			else
				aDate.each do |hDate|
					@xml.tag!('gmd:date') do
						dateClass.writeXML(hDate)
					end
				end
			end

			# citation - edition
			s = hCitation[:citEdition]
			if !s.nil?
				@xml.tag!('gmd:edition') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:edition')
			end

			# citation - resource identifiers - MD_Identifier
			#   resource identifiers come from 2 sources
			#      1. from resourceIdentifier block
			aResIDs = hCitation[:citResourceIDs]
			needIdTag = true
			unless aResIDs.empty?
				aResIDs.each do |hResID|
					@xml.tag!('gmd:identifier') do
						needIdTag = false
						idClass.writeXML(hResID)
					end
				end
			end

			#      2. from additionalIdentifier > doi
			# MD_Identifier from doi
			s = hCitation[:citDOI]
			unless s.nil?
				intResID = intMetadataClass.newResourceId
				intResID[:identifier] = s
				intCit = intMetadataClass.newCitation
				intCit[:citTitle] = 'Document Object Identifier'
				intResID[:identifierCitation] = intCit
				@xml.tag!('gmd:identifier') do
					needIdTag = false
					idClass.writeXML(intResID)
				end
			end

			# if show empty identifier tags is true,
			#    only show 1 empty MD_Identifier tag per citation
			if $showEmpty && needIdTag
				@xml.tag!('gmd:identifier')
			end

			# citation - cited responsible party
			aResParty = hCitation[:citResponsibleParty]
			if !aResParty.empty?
				aResParty.each do |rParty|
					@xml.tag!('gmd:citedResponsibleParty') do
						rPartyClass.writeXML(rParty)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:citedResponsibleParty')
			end

			# citation - presentation forms - CI_PresentationFormCode
			aPresForms = hCitation[:citResourceForms]
			if !aPresForms.empty?
				aPresForms.each do |presForm|
					@xml.tag!('gmd:presentationForm') do
						presFormClass.writeXML(presForm)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:presentationForm')
			end

			# citation - ISBN
			s = hCitation[:citISBN]
			if !s.nil?
				@xml.tag!('gmd:ISBN') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:ISBN')
			end

			# citation - ISSN
			s = hCitation[:citISSN]
			if !s.nil?
				@xml.tag!('gmd:ISSN') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:ISSN')
			end

		end

	end

end
