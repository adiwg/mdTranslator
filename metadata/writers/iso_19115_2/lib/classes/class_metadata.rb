# ISO <<Class>> MI_Metadata
# writer output in XML

# History:
# 	Stan Smith 2013-08-09 original script
# 	Stan Smith 2013-09-25 added distribution
# 	Stan Smith 2013-09-25 added data quality
# 	Stan Smith 2013-09-25 added metadata maintenance
# 	Stan Smith 2013-09-25 added reference system info
# 	Stan Smith 2013-12-27 added parent identifier
#   Stan Smith 2014-05-14 modify for JSON schema 0.4.0
#   Stan Smith 2014-05-14 refactored method calls to be consistent w/ other classes
#   Stan Smith 2014-05-28 added resource URI

require 'builder'
require 'uuidtools'
require 'date'
require Rails.root + 'metadata/writers/iso_19115_2/lib/codelists/code_characterSet'
require Rails.root + 'metadata/writers/iso_19115_2/lib/codelists/code_scope'
require Rails.root + 'metadata/writers/iso_19115_2/lib/codelists/code_referenceSystemInfo'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_responsibleParty'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_dataIdentification'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_distribution'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_metadataExtension'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_dataQuality'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_maintenanceInformation'
require Rails.root + 'metadata/internal/module_dateTimeFun'

class MI_Metadata

	def initialize(xml)
		@xml = xml
	end

	def writeXML(internalObj)

		# classes used in MD_Metadata
		charCode = MD_CharacterSetCode.new(@xml)
		scopeCode = MD_ScopeCode.new(@xml)
		rSysCode = ReferenceSystemInfo.new(@xml)
		rPartyClass = CI_ResponsibleParty.new(@xml)
		dataIdClass = MD_DataIdentification.new(@xml)
		distClass = MD_Distribution.new(@xml)
		mdExtClass = MD_MetadataExtensionInformation.new(@xml)
		dqClass = DQ_DataQuality.new(@xml)
		metaMaintClass = MD_MaintenanceInformation.new(@xml)

		intMetadata = internalObj[:metadata]
		hMetaInfo = intMetadata[:metadataInfo]
		hResInfo = intMetadata[:resourceInfo]
		aAssocRes = intMetadata[:associatedResources]
		$intContactList = internalObj[:contacts]

		# document head
		@xml.instruct! :xml, encoding: 'UTF-8'
		@xml.comment!('core gmi based instance document ISO 19115-2')
		@xml.tag!('gmi:MI_Metadata',{'xmlns:gmi' => 'http://www.isotc211.org/2005/gmi',
									'xmlns:gmd' => 'http://www.isotc211.org/2005/gmd',
									'xmlns:gco' => 'http://www.isotc211.org/2005/gco',
									'xmlns:gml' => 'http://www.opengis.net/gml/3.2',
									'xmlns:gsr' => 'http://www.isotc211.org/2005/gsr',
									'xmlns:gss' => 'http://www.isotc211.org/2005/gss',
									'xmlns:gst' => 'http://www.isotc211.org/2005/gst',
									'xmlns:gmx' => 'http://www.isotc211.org/2005/gmx',
									'xmlns:gfc' => 'http://www.isotc211.org/2005/gfc',
									'xmlns:srv' => 'http://www.isotc211.org/2005/srv',
									'xmlns:xlink' => 'http://www.w3.org/1999/xlink',
									'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
									'xsi:schemaLocation' => 'http://www.isotc211.org/2005/gmi ftp://ftp.ncddc.noaa.gov/pub/Metadata/Online_ISO_Training/Intro_to_ISO/schemas/ISObio/schema.xsd'}) do

			# metadata information - file identifier - default
			@xml.tag!('gmd:fileIdentifier') do
				s = hMetaInfo[:metadataId]
				if s.nil?
					# generate fileIdentifier if one not provided
					@xml.tag!('gco:CharacterString',UUIDTools::UUID.random_create.to_s)
				else
					@xml.tag!('gco:CharacterString',s)
				end
			end

			# metadata information - file language - default
			@xml.tag!('gmd:language') do
				# all xml is written in US English
				@xml.tag!('gco:CharacterString','eng; USA')
			end

			# metadata information - character set - default
			@xml.tag!('gmd:characterSet') do
				# all out put is in utf8
				charCode.writeXML('utf8')
			end

			# metadata information - parent identifier
			s = hMetaInfo[:parentMetadataId]
			if !s.nil?
				@xml.tag!('gmd:parentIdentifier') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:parentIdentifier')
			end

			# metadata information - file hierarchy - default dataset
			aHierarchy = hMetaInfo[:metadataScope]
			if aHierarchy.empty?
				@xml.tag!('gmd:hierarchyLevel') do
					scopeCode.writeXML('dataset')
				end
			else
				aHierarchy.each do |hierarchy|
					@xml.tag!('gmd:hierarchyLevel') do
						scopeCode.writeXML(hierarchy)
					end
				end
			end

			# metadata information - metadata custodian - required
			aCustodians = hMetaInfo[:metadataCustodians]
			if aCustodians.empty?
				@xml.tag!('gmd:contact', {'gco:nilReason' => 'missing'})
			else
				aCustodians.each do |hCustodian|
					@xml.tag!('gmd:contact') do
						rPartyClass.writeXML(hCustodian)
					end
				end
			end

			# metadata information - date stamp - required - default to now()
			@xml.tag!('gmd:dateStamp') do

				# if date not supplied, fill with today's date
				hDate = hMetaInfo[:metadataCreateDate]
				if hDate.empty?
					mDate = AdiwgDateTimeFun.stringDateFromDateTime(DateTime.now, 'YMD')
				else
					mDateTime = hDate[:dateTime]
					mDateRes = hDate[:dateResolution]
					if mDateTime.nil?
						mDate = AdiwgDateTimeFun.stringDateFromDateTime(DateTime.now, 'YMD')
					else
						mDate = AdiwgDateTimeFun.stringDateFromDateTime(mDateTime, mDateRes)
					end
				end

				@xml.tag!('gco:Date',mDate)
			end

			# metadata information - metadata standard name - default
			@xml.tag!('gmd:metadataStandardName') do
				@xml.tag!('gco:CharacterString','ISO 19115-2')
			end

			# metadata information - metadata standard version - default
			@xml.tag!('gmd:metadataStandardVersion') do
				@xml.tag!('gco:CharacterString','ISO 19115-2:2009(E)')
			end

			# metadata information - reference system
			aRefSystems = hResInfo[:spatialReferenceSystems]
			if !aRefSystems.empty?
				aRefSystems.each do |rSystem|
					rSysCode.writeXML(rSystem)
				end
			elsif $showEmpty
				@xml.tag!('gmd:referenceSystemInfo')
			end

			# metadata information - metadata extension info
			aExtensions = hMetaInfo[:extensions]
			if !aExtensions.empty?
				aExtensions.each do |hExtension|
					@xml.tag!('gmd:metadataExtensionInfo') do
						mdExtClass.writeXML(hExtension)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:metadataExtensionInfo')
			end

			# metadata information - identification info - required
			if hResInfo.empty?
				@xml.tag!('gmd:identificationInfo', {'gco:nilReason' => 'missing'})
			else
				@xml.tag!('gmd:identificationInfo') do
					dataIdClass.writeXML(hResInfo, aAssocRes)
				end
			end

			# metadata information - content info
			# ... information about data and link to 19110
			# ... on hold until 19115-1 release

			# metadata information - distribution info []
			aDistInfo = intMetadata[:distributorInfo]
			if !aDistInfo.empty?
				@xml.tag!('gmd:distributionInfo') do
					distClass.writeXML(aDistInfo)
				end
			elsif $showEmpty
				@xml.tag!('gmd:distributionInfo')
			end

			# metadata information - data quality info
			aDQInfo = hResInfo[:dataQualityInfo]
			if !aDQInfo.empty?
				aDQInfo.each do |hDQInfo|
					@xml.tag!('gmd:dataQualityInfo') do
						dqClass.writeXML(hDQInfo)
					end
				end
			elsif $showEmpty
				xml.tag!('gmd:dataQualityInfo')
			end

			# metadata information - metadata maintenance
			hMetaMaint = hMetaInfo[:maintInfo]
			if !hMetaMaint.empty?
				@xml.tag!('gmd:metadataMaintenance') do
					metaMaintClass.writeXML(hMetaMaint)
				end
			elsif $showEmpty
				xml.tag!('gmd:metadataMaintenance')
			end

		end
	end
end