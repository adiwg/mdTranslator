# ISO <<Class>> MD_Vouchers
# writer output in XML

# History:
# 	Stan Smith 2013-11-19 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'class_responsibleParty'

class MD_Vouchers

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hVoucher)

		# classes used in MD_Vouchers
		rPartyClass = CI_ResponsibleParty.new(@xml)

		@xml.tag!('gmd:MD_Vouchers') do

			# voucher - specimen - required
			s = hVoucher[:specimen]
			if s.nil?
				@xml.tag!('gmd:specimen',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:specimen') do
					@xml.tag!('gco:CharacterString',s)
				end
			end

			# voucher - repository - required - MD_ResponsibleParty
			hContacts = hVoucher[:repository]
			if hContacts.empty?
				@xml.tag!('gmd:reposit',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:reposit') do
					rPartyClass.writeXML(hContacts)
				end

			end

		end

	end

end
