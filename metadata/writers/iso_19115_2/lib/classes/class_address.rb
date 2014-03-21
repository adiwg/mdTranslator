# ISO <<Class>> CI_Address
# writer output in XML

# History:
# 	Stan Smith 2013-08-09 original script

require 'builder'

class CI_Address

	def initialize(xml)
		@xml = xml
	end

	def writeXML(address)

		deliveryPoints = address[:deliveryPoints].length
		eMails = address[:eMailList].length

		if deliveryPoints + eMails > 0
			@xml.tag!('gmd:CI_Address') do
				# address - address
				if deliveryPoints > 0

					# address - delivery points (address lines)
					aDeliveryPoints = address[:deliveryPoints]
					aDeliveryPoints.each do |myPoint|
						@xml.tag!('gmd:deliveryPoint') do
							@xml.tag!('gco:CharacterString',myPoint)
						end
					end

				elsif $showEmpty
					@xml.tag!('gmd:deliveryPoint')
				end

				# address - city
				s = address[:city]
				if !s.nil?
					@xml.tag!('gmd:city') do
						@xml.tag!('gco:CharacterString',s)
					end
				elsif $showEmpty
					@xml.tag!('gmd:city')
				end

				# address - admin area (state)
				s = address[:adminArea]
				if !s.nil?
					@xml.tag!('gmd:administrativeArea') do
						@xml.tag!('gco:CharacterString',s)
					end
				elsif $showEmpty
					@xml.tag!('gmd:administrativeArea')
				end

				# address - postal code
				s = address[:postalCode]
				if !s.nil?
					@xml.tag!('gmd:postalCode') do
						@xml.tag!('gco:CharacterString',s)
					end
				elsif $showEmpty
					@xml.tag!('gmd:postalCode')
				end

				# address - country
				s = address[:country]
				if !s.nil?
					@xml.tag!('gmd:country') do
						@xml.tag!('gco:CharacterString',s)
					end
				elsif $showEmpty
					@xml.tag!('gmd:country')
				end

				# address - email addresses
				if eMails > 0
					address[:eMailList].each do |myEmail|
						@xml.tag!('gmd:electronicMailAddress') do
							@xml.tag!('gco:CharacterString',myEmail)
						end
					end
				elsif $showEmpty
					@xml.tag!('gmd:electronicMailAddress')
				end

			end
		end

	end

end