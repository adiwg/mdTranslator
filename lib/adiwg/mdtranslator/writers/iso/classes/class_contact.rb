# ISO <<Class>> CI_Contact
# writer output in XML

# History:
# 	Stan Smith 2013-08-12 original script
#   Stan Smith 2014-05-14 modified for JSON schema version 0.4.0
#   Stan Smith 2014-05-16 added method to return contact from array
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'class_telephone'
require 'class_address'
require 'class_onlineResource'

class CI_Contact

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hContact)

		# classes used in MD_Metadata
		pBookClass = CI_Telephone.new(@xml)
		addClass = CI_Address.new(@xml)
		resourceClass = CI_OnlineResource.new(@xml)

		@xml.tag!('gmd:CI_Contact') do

			# contact - phone list - all services
			aPhones = hContact[:phones]
			if !aPhones.empty?
				@xml.tag!('gmd:phone') do
					pBookClass.writeXML(aPhones)
				end
			elsif $showAllTags
				@xml.tag!('gmd:phone')
			end

			# contact - address
			hAddress = hContact[:address]
			if !hAddress.empty?
				@xml.tag!('gmd:address') do
					addClass.writeXML(hAddress)
				end
			elsif $showAllTags
				@xml.tag!('gmd:address')
			end

			# contact - online resource
			aResource = hContact[:onlineRes]
			if !aResource.empty?
				@xml.tag!('gmd:onlineResource') do
					resourceClass.writeXML(aResource[0])
				end
			elsif $showAllTags
				@xml.tag!('gmd:onlineResource')
			end

			# contact - contact instructions
			s = hContact[:contactInstructions]
			if !s.nil?
				@xml.tag!('gmd:contactInstructions') do
					@xml.tag!('gco:CharacterString',hContact[:contactInstructions])
				end
			elsif $showAllTags
				@xml.tag!('gmd:contactInstructions')
			end

		end
	end

	def getContact(contactID)

		# find contact in contact array and return the hash
		$intContactList.each do |hContact|
			if hContact[:contactId] == contactID
				return hContact
			end
		end

		return {}

	end

end