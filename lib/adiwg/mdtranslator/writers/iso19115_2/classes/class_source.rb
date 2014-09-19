# ISO <<Class>> LI_Source
# writer output in XML

# History:
# 	Stan Smith 2013-11-20 original script
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure

require 'class_citation'
require 'class_processStep'

class LI_Source

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hSource)

		# classes used
		citationClass = CI_Citation.new(@xml)
		pStepClass = LI_ProcessStep.new(@xml)

		@xml.tag!('gmd:LI_Source') do

			# source - description - required
			s = hSource[:sourceDescription]
			if s.nil?
				@xml.tag!('gmd:description',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:description') do
					@xml.tag!('gco:CharacterString',s)
				end
			end

			# source - citation
			hCitation = hSource[:sourceCitation]
			if !hCitation.empty?
				@xml.tag!('gmd:sourceCitation') do
					citationClass.writeXML(hCitation)
				end
			elsif $showAllTags
				@xml.tag!('gmd:sourceCitation')
			end

			# source - process steps
			aSteps = hSource[:sourceSteps]
			unless aSteps.empty?
				aSteps.each do |hStep|
					@xml.tag!('gmd:sourceStep') do
						pStepClass.writeXML(hStep)
					end
				end
			end

		end

	end

end
