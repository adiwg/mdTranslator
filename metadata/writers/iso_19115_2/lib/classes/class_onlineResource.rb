# ISO <<Class>> CI_OnlineResource
# writer output in XML

# History:
# 	Stan Smith 2013-08-14 original script

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/codelists/code_onlineFunction'

class CI_OnlineResource

	def initialize(xml)
		@xml = xml
	end

	def writeXML(resource)

		# classes used
		olFunctionCode = CI_OnLineFunctionCode.new(@xml)

		@xml.tag! 'gmd:CI_OnlineResource' do

			# online resource - link - required
			s = resource[:olResLink]
			if s.nil?
				@xml.tag!('gmd:linkage',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:linkage') do
					@xml.tag!('gmd:URL',s)
				end
			end

			# online resource - link name
			s = resource[:olResName]
			if !s.nil?
				@xml.tag!('gmd:name') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:name')
			end

			# online resource - link description
			s = resource[:olResDesc]
			if !s.nil?
				@xml.tag!('gmd:description') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:description')
			end

			# online resource - link function - CI_OnLineFunctionCode
			s = resource[:olResFunction]
			if !s.nil?
				@xml.tag!('gmd:function') do
					olFunctionCode.writeXML(s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:function')
			end

		end

	end

end