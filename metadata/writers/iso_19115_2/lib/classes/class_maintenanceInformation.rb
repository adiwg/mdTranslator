# ISO <<Class>> MD_MaintenanceInformation
# writer output in XML

# History:
# 	Stan Smith 2013-10-31 original script
# 	Stan Smith 2013-12-18 added contact

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/codelists/code_maintenanceFrequency'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_responsibleParty'

class MD_MaintenanceInformation

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hMaintInfo)

		# classes used
		maintFreqCode = MD_MaintenanceFrequencyCode.new(@xml)
		rPartyClass = CI_ResponsibleParty.new(@xml)

		@xml.tag! 'gmd:MD_MaintenanceInformation' do

			# maintenance information - frequency code - required
			s = hMaintInfo[:maintFreq]
			if s.nil?
				@xml.tag!('gmd:maintenanceAndUpdateFrequency', {'gco:nilReason'=>'unknown'})
			else
				@xml.tag!('gmd:maintenanceAndUpdateFrequency') do
					maintFreqCode.writeXML(s)
				end
			end

			# maintenance information - note
			aNotes = hMaintInfo[:maintNotes]
			if !aNotes.empty?
				aNotes.each do |note|
					@xml.tag!('gmd:maintenanceNote') do
						@xml.tag!('gco:CharacterString',note)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:maintenanceNote')
			end

			# maintenance information - contact - CI_ResponsibleParty
			aContacts = hMaintInfo[:maintContacts]
			if aContacts.empty? && $shoeEmpty
				@xml.tag!('gmd:contact')
			else
				aContacts.each do |hContact|
					@xml.tag!('gmd:contact') do
						rPartyClass.writeXML(hContact)
					end
				end
			end

		end

	end

end