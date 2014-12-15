# ISO 19115-2 <<Class>> MI_Metadata
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
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-08-18 add dataSetURI
#   Stan Smith 2014-09-03 replaced spatial reference system code with named, epsg, and
#   ... wkt reference system descriptions using RS_Identifier for 0.7.0
#   Stan Smith 2014-09-19 changed file identifier to read from internal storage as
#   ... an MD_Identifier class.  To support version 0.8.0 json.
#   Stan Smith 2014-10-07 changed source of dataSetURI to
#   ... metadata: {resourceInfo: {citation: {citOlResources[0]: {olResURI:}}}}
#   Stan Smith 2014-10-10 modified to pass minimum metadata input test
#   ... test were added to handle a missing metadata > metadataInfo block in the input
#   Stan Smith 2014-11-06 changed hierarchy level to load values from resourceInfo > resourceType

require 'code_characterSet'
require 'code_scope'
require 'class_responsibleParty'
require 'class_metadataExtension'
require 'class_dataIdentification'
require 'class_distribution'
require 'class_dataQuality'
require 'class_maintenanceInformation'
require 'class_referenceSystem'
require 'module_dateTimeFun'

class MI_Metadata

    def initialize(xml)
        @xml = xml
    end

    def writeXML(internalObj)

        # classes used in MD_Metadata
        charCode = MD_CharacterSetCode.new(@xml)
        scopeCode = MD_ScopeCode.new(@xml)
        rPartyClass = CI_ResponsibleParty.new(@xml)
        mdExtClass = MD_MetadataExtensionInformation.new(@xml)
        dataIdClass = MD_DataIdentification.new(@xml)
        distClass = MD_Distribution.new(@xml)
        dqClass = DQ_DataQuality.new(@xml)
        metaMaintClass = MD_MaintenanceInformation.new(@xml)
        refSysClass = MD_ReferenceSystem.new(@xml)

        intMetadata = internalObj[:metadata]
        hMetaInfo = intMetadata[:metadataInfo]
        hResInfo = intMetadata[:resourceInfo]
        aAssocRes = intMetadata[:associatedResources]
        $intContactList = internalObj[:contacts]

        # document head
        @xml.instruct! :xml, encoding: 'UTF-8'
        @xml.comment!('core gmi based instance document ISO 19115-2')
        @xml.tag!('gmi:MI_Metadata', {'xmlns:gmi' => 'http://www.isotc211.org/2005/gmi',
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
            # the internal object stores the file identifier as a MD_Identifier to support 19115-1
            # hMetaInfo => metadata > metadataInfo
            # hMetaInfo[:metadataId] => MD_Identifier
            # ISO 19115-2 only support the file identifier as a character string
            @xml.tag!('gmd:fileIdentifier') do
                s = nil
                if hMetaInfo
                    if hMetaInfo[:metadataId]
                        s = hMetaInfo[:metadataId][:identifier]
                        unless s.nil?
                            @xml.tag!('gco:CharacterString', s)
                        end
                    end
                end
                if s.nil?
                    # generate fileIdentifier if one not provided
                    @xml.tag!('gco:CharacterString', UUIDTools::UUID.random_create.to_s)
                end
            end

            # metadata information - file language - default
            @xml.tag!('gmd:language') do
                # all xml is written in US English
                @xml.tag!('gco:CharacterString', 'eng; USA')
            end

            # metadata information - character set - default
            @xml.tag!('gmd:characterSet') do
                # all out put is in utf8
                charCode.writeXML('utf8')
            end

            # metadata information - parent identifier
            # the internal object stores the parent identifier as a CI_Citation to support 19115-1
            # hMetaInfo => metadata > metadataInfo
            # hMetaInfo[:parentMetadata] => hParent => CI_Citation
            # ISO 19115-2 only support the parent identifier as a character string
            s = nil
            if hMetaInfo
                if hMetaInfo[:parentMetadata]
                    hParent = hMetaInfo[:parentMetadata]
                    if !hParent.empty?
                        s = hParent[:citTitle]
                        aResIds = hParent[:citResourceIds]
                        if aResIds.length > 0
                            s += ' ids: | '
                            aResIds.each do |resource|
                                s += resource[:identifierType] + ': ' + resource[:identifier] + ' | '
                            end
                        end
                    end
                end
            end
            if !s.nil?
                @xml.tag!('gmd:parentIdentifier') do
                    @xml.tag!('gco:CharacterString', s)
                end
            elsif $showAllTags
                @xml.tag!('gmd:parentIdentifier')
            end

            # metadata information - hierarchy level - defaults to 'dataset',
            # values taken from resourceInfo > resourceType
            fileHierarchy = false
            s = hResInfo[:resourceType]
            if s != ''
                fileHierarchy = true
                @xml.tag!('gmd:hierarchyLevel') do
                    scopeCode.writeXML(s)
                end
            end
            if !fileHierarchy
                @xml.tag!('gmd:hierarchyLevel') do
                    scopeCode.writeXML('dataset')
                end
            end

            # metadata information - metadata custodian - required
            custodians = false
            if hMetaInfo
                if hMetaInfo[:metadataCustodians]
                    aCustodians = hMetaInfo[:metadataCustodians]
                    unless aCustodians.empty?
                        custodians = true
                        aCustodians.each do |hCustodian|
                            @xml.tag!('gmd:contact') do
                                rPartyClass.writeXML(hCustodian)
                            end
                        end
                    end
                end
            end
            if !custodians
                @xml.tag!('gmd:contact', {'gco:nilReason' => 'missing'})
            end

            # metadata information - date stamp - required - default to now()
            mDate = AdiwgDateTimeFun.stringDateFromDateTime(DateTime.now, 'YMD')
            if hMetaInfo
                if hMetaInfo[:metadataCreateDate]
                    hDate = hMetaInfo[:metadataCreateDate]
                    unless hDate.empty?
                        mDateTime = hDate[:dateTime]
                        mDateRes = hDate[:dateResolution]
                        unless mDateTime.nil?
                            mDate = AdiwgDateTimeFun.stringDateFromDateTime(mDateTime, mDateRes)
                        end
                    end
                end
            end
            @xml.tag!('gmd:dateStamp') do
                @xml.tag!('gco:Date', mDate)
            end

            # metadata information - metadata standard name - default
            @xml.tag!('gmd:metadataStandardName') do
                @xml.tag!('gco:CharacterString', 'ISO 19115-2')
            end

            # metadata information - metadata standard version - default
            @xml.tag!('gmd:metadataStandardVersion') do
                @xml.tag!('gco:CharacterString', 'ISO 19115-2:2009(E)')
            end

            # metadata information - dataset URI
            # for the dataset URI adiwgJson follows the ISO 19115-1 convention which is
            # ... to include links to the resource in the onlineResource section of the
            # ... resource citation.  Because citation onlineResource(s) are not supported
            # ... in -2, the URI from the first onlineResource in the adiwgJson is used
            # ... for the datasetURI.
            # ... metadata: {resourceInfo: {citation: {citOlResources[0]: {olResURI:}}}}
            s = nil
            if hResInfo[:citation]
                if hResInfo[:citation][:citOlResources][0]
                    if hResInfo[:citation][:citOlResources][0][:olResURI]
                        s = hResInfo[:citation][:citOlResources][0][:olResURI]
                    end
                end
            end
            if !s.nil?
                @xml.tag!('gmd:dataSetURI') do
                    @xml.tag!('gco:CharacterString', s)
                end
            elsif $showAllTags
                @xml.tag!('gmd:dataSetURI')
            end

            # metadata information - reference system
            hRefSystems = hResInfo[:spatialReferenceSystem]
            if !hRefSystems.empty?

                # named reference systems
                aRefNames = hRefSystems[:sRNames]
                aRefNames.each do |refName|
                    @xml.tag!('gmd:referenceSystemInfo') do
                        refSysClass.writeXML(refName, 'name')
                    end
                end

                # epsg reference systems
                aRefNames = hRefSystems[:sREPSGs]
                aRefNames.each do |refName|
                    @xml.tag!('gmd:referenceSystemInfo') do
                        refSysClass.writeXML(refName, 'epsg')
                    end
                end

                # wkt reference systems
                aRefNames = hRefSystems[:sRWKTs]
                aRefNames.each do |refName|
                    @xml.tag!('gmd:referenceSystemInfo') do
                        refSysClass.writeXML(refName, 'wkt')
                    end
                end

            elsif $showAllTags
                @xml.tag!('gmd:referenceSystemInfo')
            end

            # metadata information - metadata extension info
            extensions = false
            if hMetaInfo
                if hMetaInfo[:extensions]
                    aExtensions = hMetaInfo[:extensions]
                    if !aExtensions.empty?
                        extensions = true
                        aExtensions.each do |hExtension|
                            @xml.tag!('gmd:metadataExtensionInfo') do
                                mdExtClass.writeXML(hExtension)
                            end
                        end
                    end
                end
            end
            if !extensions && $showAllTags
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
            elsif $showAllTags
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
            elsif $showAllTags
                @xml.tag!('gmd:dataQualityInfo')
            end

            # metadata information - metadata maintenance
            maintInfo = false
            if hMetaInfo
                if hMetaInfo[:maintInfo]
                    hMetaMaint = hMetaInfo[:maintInfo]
                    if !hMetaMaint.empty?
                        maintInfo = true
                        @xml.tag!('gmd:metadataMaintenance') do
                            metaMaintClass.writeXML(hMetaMaint)
                        end
                    end
                end
            end
            if !maintInfo && $showAllTags
                @xml.tag!('gmd:metadataMaintenance')
            end

        end
    end

end