# ISO <<Class>> MD_MetadataExtensionInformation
# writer output in XML

# History:
# 	Stan Smith 2013-11-22 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'code_obligation'
require 'code_datatype'
require 'class_onlineResource'
require 'class_responsibleParty'

class MD_MetadataExtensionInformation

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hExtension)

		# classes used
		olResClass = CI_OnlineResource.new(@xml)
		rPartyClass = CI_ResponsibleParty.new(@xml)
		obCode = MD_ObligationCode.new(@xml)
		dataTCode = MD_DatatypeCode.new(@xml)

		@xml.tag!('gmd:MD_MetadataExtensionInformation') do

			# metadata extension - online resource - CI_OnLineResource
			hOLResource = hExtension[:onLineResource]
			if !hOLResource.empty?
				@xml.tag!('gmd:extensionOnLineResource') do
					olResClass.writeXML(hOLResource)
				end
			elsif $showAllTags
				@xml.tag!('gmd:extensionOnLineResource')
			end

			# metadata extension = extended element information
			@xml.tag!('gmd:extendedElementInformation') do
				@xml.tag!('gmd:MD_ExtendedElementInformation') do

					# extended element info - name - required
					s = hExtension[:extName]
					if s.nil?
						@xml.tag!('gmd:name',{'gco:nilReason'=>'missing'})
					else
						@xml.tag!('gmd:name') do
							@xml.tag!('gco:CharacterString',s)
						end
					end

					# extended element info - short name
					s = hExtension[:extShortName]
					if !s.nil?
						@xml.tag!('gmd:shortName') do
							@xml.tag!('gco:CharacterString',s)
						end
					elsif $showAllTags
						@xml.tag!('gmd:shortName')
					end

					# extended element info - definition - required
					s = hExtension[:extDefinition]
					if s.nil?
						@xml.tag!('gmd:definition',{'gco:nilReason'=>'missing'})
					else
						@xml.tag!('gmd:definition') do
							@xml.tag!('gco:CharacterString',s)
						end
					end

					# extended element info - obligation
					s = hExtension[:obligation]
					if !s.nil?
						@xml.tag!('gmd:obligation') do
							obCode.writeXML(s)
						end
					elsif $showAllTags
						@xml.tag!('gmd:obligation')
					end

					# extended element info - data type - required
					s = hExtension[:dataType]
					if s.nil?
						@xml.tag!('gmd:dataType',{'gco:nilReason'=>'missing'})
					else
						@xml.tag!('gmd:dataType') do
							dataTCode.writeXML(s)
						end
					end

					# extended element info - maximum occurrence
					s = hExtension[:maxOccurrence]
					if !s.nil?
						@xml.tag!('gmd:maximumOccurrence') do
							@xml.tag!('gco:CharacterString',s)
						end
					elsif $showAllTags
						@xml.tag!('gmd:maximumOccurrence')
					end

					# extended element info - parent entity - required
					aParents = hExtension[:parentEntities]
					if aParents.empty?
						@xml.tag!('gmd:parentEntity',{'gco:nilReason'=>'missing'})
					else
						aParents.each do |parent|
							@xml.tag!('gmd:parentEntity') do
								@xml.tag!('gco:CharacterString',parent)
							end
						end
					end

					# extended element info - rule
					s = hExtension[:rule]
					if s.nil?
						@xml.tag!('gmd:rule',{'gco:nilReason'=>'missing'})
					else
						@xml.tag!('gmd:rule') do
							@xml.tag!('gco:CharacterString',s)
						end
					end

					# extended element info - rationale
					aRations = hExtension[:rationales]
					if aRations.empty?
						@xml.tag!('gmd:rationale')
					else
						aRations.each do |ration|
							@xml.tag!('gmd:rationale') do
								@xml.tag!('gco:CharacterString', ration)
							end
						end
					end

					# extended element info - source - CI_ResponsibleParty
					aSources = hExtension[:extSources]
					if aSources.empty?
						@xml.tag!('gmd:source',{'gco:nilReason'=>'missing'})
					else
						aSources.each do |hSource|
							@xml.tag!('gmd:source') do
								rPartyClass.writeXML(hSource)
							end
						end
					end

				end
			end

		end

	end

end
