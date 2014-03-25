# ISO <<Class>> CI_Citation
# writer output in XML

# History:
# 	Stan Smith 2013-08-26 original script
# 	Stan Smith 2013-12-30 added ISBN, ISSN

require 'builder'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_responsibleParty'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_date'

class CI_Citation

	def initialize(xml)
		@xml = xml
	end

	def writeXML(citation)

		# classes used in MD_Metadata
		rPartyClass = CI_ResponsibleParty.new(@xml)
		dateClass = CI_Date.new(@xml)

		@xml.tag!('gmd:CI_Citation') do

			# citation - title - required
			s = citation[:citTitle]
			if s.nil?
				@xml.tag!('gmd:title',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:title') do
					@xml.tag!('gco:CharacterString',s)
				end
			end

			# citation - date - required
			aDate = citation[:citDate]
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
			s = citation[:citEdition]
			if !s.nil?
				@xml.tag!('gmd:edition') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:edition')
			end

			# citation - cited responsible party
			aResParty = citation[:citResParty]
			if !aResParty.empty?
				aResParty.each do |rParty|
					@xml.tag!('gmd:citedResponsibleParty') do
						rPartyClass.writeXML(rParty)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:citedResponsibleParty')
			end

			# citation - ISBN
			s = citation[:citISBN]
			if !s.nil?
				@xml.tag!('gmd:ISBN') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:ISBN')
			end

			# citation - ISSN
			s = citation[:citISSN]
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
