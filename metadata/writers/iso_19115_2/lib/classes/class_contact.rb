# ISO <<Class>> CI_Contact
# writer output in XML

# History:
# 	Stan Smith 2013-08-12 original script

require 'builder'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_telephone'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_address'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_onlineResource'

class CI_Contact

	def initialize(xml)
		@xml = xml
	end

	def writeXML(contact)

		# classes used in MD_Metadata
		pBookClass = CI_Telephone.new(@xml)
		addClass = CI_Address.new(@xml)
		resourceClass = CI_OnlineResource.new(@xml)

		@xml.tag!('gmd:CI_Contact') do

			# contact - phone list
			hPhoneBook = {}
			if !contact[:voicePhones].empty?
				hPhoneBook[:voice] = contact[:voicePhones]
			end
			if !contact[:faxPhones].empty?
				hPhoneBook[:fax] = contact[:faxPhones]
			end
			if !hPhoneBook.empty?
				@xml.tag!('gmd:phone') do
					pBookClass.writeXML(hPhoneBook)
				end
			elsif $showEmpty
				@xml.tag!('gmd:phone')
			end

			# contact - address
			hAddress = contact[:address]
			if !hAddress.empty?
				@xml.tag!('gmd:address') do
					addClass.writeXML(hAddress)
				end
			elsif $showEmpty
				@xml.tag!('gmd:address')
			end

			# contact - online resource
			aResource = contact[:onlineRes]
			if !aResource.empty?
				@xml.tag!('gmd:onlineResource') do
					resourceClass.writeXML(aResource[0])
				end
			elsif $showEmpty
				@xml.tag!('gmd:onlineResource')
			end

			# contact - contact instructions
			s = contact[:contactInstructions]
			if !s.nil?
				@xml.tag!('gmd:contactInstructions') do
					@xml.tag!('gco:CharacterString',contact[:contactInstructions])
				end
			elsif $showEmpty
				@xml.tag!('gmd:contactInstructions')
			end

		end
	end
end