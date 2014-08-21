# ISO <<Class>> EX_VerticalExtent
# writer output in XML

# History:
# 	Stan Smith 2013-11-15 original script

class EX_VerticalExtent

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hVertEle)

		@xml.tag!('gmd:EX_VerticalExtent') do

			# vertical extent - minimum value - required
			s = hVertEle[:minValue]
			if s.nil?
				@xml.tag!('gmd:minimumValue', {'gco:nilReason' => 'missing'})
			else
				@xml.tag!('gmd:minimumValue') do
					@xml.tag!('gco:Real', s)
				end
			end

			# vertical extent - maximum value - required
			s = hVertEle[:maxValue]
			if s.nil?
				@xml.tag!('gmd:maximumValue', {'gco:nilReason' => 'missing'})
			else
				@xml.tag!('gmd:maximumValue') do
					@xml.tag!('gco:Real', s)
				end
			end

			# vertical extent - vertical crs - attributes only - required
			attributes = {}
			s = hVertEle[:crsURI]
			unless s.nil?
				attributes['xlink:href'] = s
			end
			s = hVertEle[:crsTitle]
			unless s.nil?
				attributes['xlink:title'] = s
			end

			if attributes.empty?
				attributes['gco:nilReason'] = 'missing'
			end

			@xml.tag!('gmd:verticalCRS',attributes)


		end

	end

end