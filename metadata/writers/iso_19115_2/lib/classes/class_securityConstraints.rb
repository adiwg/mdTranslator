# ISO <<Class>> MD_SecurityConstraints
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script

require 'builder'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/codelists/code_classification'

class MD_SecurityConstraints

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hSecurityCons)

		# classes used
		classCode = MD_ClassificationCode.new(@xml)

		@xml.tag!('gmd:MD_SecurityConstraints') do

			# security constraints - classification code - required
			s = hSecurityCons[:classCode]
			if s.nil?
				@xml.tag!('gmd:classification',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:classification') do
					classCode.writeXML(s)
				end
			end

			# security constraints - user note
			s = hSecurityCons[:userNote]
			if !s.nil?
				@xml.tag!('gmd:userNote') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:userNote')
			end

			# security constraints - classification system
			s = hSecurityCons[:classSystem]
			if !s.nil?
				@xml.tag!('gmd:classificationSystem') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:classificationSystem')
			end

			# security constraints - handling description
			s = hSecurityCons[:handlingDesc]
			if !s.nil?
				@xml.tag!('gmd:handlingDescription') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:handlingDescription')
			end

		end

	end

end