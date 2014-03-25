# ISO <<Class>> MD_Usage
# writer output in XML

# History:
# 	Stan Smith 2013-11-19 original script

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_responsibleParty'

class MD_Usage

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hUsage)

		# classes used in MD_Usage
		rPartyClass = CI_ResponsibleParty.new(@xml)

		@xml.tag!('gmd:MD_Usage') do

			# usage - specific usage - required
			s = hUsage[:specificUsage]
			if s.nil?
				@xml.tag!('gmd:specificUsage',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:specificUsage') do
					@xml.tag!('gco:CharacterString',s)
				end
			end

			# usage - user determined limitations
			s = hUsage[:userLimits]
			if !s.nil?
				@xml.tag!('gmd:userDeterminedLimitations') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:userDeterminedLimitations')
			end

			# usage - user contact info - responsible party
			aContacts = hUsage[:userContacts]
			if !aContacts.empty?
				aContacts.each do |rParty|
					@xml.tag!('gmd:userContactInfo') do
						rPartyClass.writeXML(rParty)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:userContactInfo')
			end

		end

	end

end
