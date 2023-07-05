# ISO 19115-2 <<Class>> MI_Metadata
# 19115-2 writer output in XML.

# History:
#  Stan Smith 2018-05-03 add variable for changing XSD location
#  Stan Smith 2018-04-10 add error and warning messaging
#  Stan Smith 2018-01-27 add metadata constraints
#  Stan Smith 2016-11-15 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-08-27 added support for content information
#  Stan Smith 2015-07-30 added support for grid information
#  Stan Smith 2015-07-28 added support for PT_Locale
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-12 added support for user to specify metadataCharacterSet
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-29 set builder object '@xml' into string 'metadata'
#  Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#  Stan Smith 2014-11-06 changed hierarchy level to load values from resourceInfo > resourceType
#  Stan Smith 2014-10-10 modified to pass minimum metadata input test
#   ... test were added to handle a missing metadata > metadataInfo block in the input
#  Stan Smith 2014-10-07 changed source of dataSetURI to
#   ... metadata: {resourceInfo: {citation: {citOlResources[0]: {olResURI:}}}}
#  Stan Smith 2014-09-19 changed file identifier to read from internal storage as
#   ... an MD_Identifier class.  To support version 0.8.0 json.
#  Stan Smith 2014-09-03 replaced spatial reference system code with named, epsg, and
#   ... wkt reference system descriptions using RS_Identifier for 0.7.0
#  Stan Smith 2014-08-18 add dataSetURI
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#  Stan Smith 2014-05-28 added resource URI
#  Stan Smith 2014-05-14 refactored method calls to be consistent w/ other classes
#  Stan Smith 2014-05-14 modify for JSON schema 0.4.0
# 	Stan Smith 2013-12-27 added parent identifier
# 	Stan Smith 2013-09-25 added reference system info
# 	Stan Smith 2013-09-25 added metadata maintenance
# 	Stan Smith 2013-09-25 added data quality
# 	Stan Smith 2013-09-25 added distribution
# 	Stan Smith 2013-08-09 original script

require 'uuidtools'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
require_relative 'class_hierarchy'
require_relative 'class_responsibleParty'
require_relative 'class_locale'
require_relative 'class_spatialRepresentation'
require_relative 'class_referenceSystem'
require_relative 'class_extension'
require_relative 'class_dataIdentification'
require_relative 'class_coverageDescription'
require_relative 'class_distribution'
require_relative 'class_dataQuality'
require_relative 'class_useConstraints'
require_relative 'class_legalConstraints'
require_relative 'class_securityConstraints'
require_relative 'class_maintenance'
require_relative 'class_gcoDateTime'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MI_Metadata

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(intObj)

                  # classes used
                  intMetadataClass = InternalMetadata.new
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  partyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                  hierarchyClass = Hierarchy.new(@xml, @hResponseObj)
                  localeClass = PT_Locale.new(@xml, @hResponseObj)
                  representationClass = SpatialRepresentation.new(@xml, @hResponseObj)
                  systemClass = MD_ReferenceSystem.new(@xml, @hResponseObj)
                  extensionClass = MD_MetadataExtensionInformation.new(@xml, @hResponseObj)
                  dataIdClass = MD_DataIdentification.new(@xml, @hResponseObj)
                  coverageClass = CoverageDescription.new(@xml, @hResponseObj)
                  distClass = MD_Distribution.new(@xml, @hResponseObj)
                  dqClass = DQ_DataQuality.new(@xml, @hResponseObj)
                  uConClass = MD_Constraints.new(@xml, @hResponseObj)
                  lConClass = MD_LegalConstraints.new(@xml, @hResponseObj)
                  sConClass = MD_SecurityConstraints.new(@xml, @hResponseObj)
                  maintenanceClass = MD_MaintenanceInformation.new(@xml, @hResponseObj)
                  dateTimeClass = GcoDateTime.new(@xml, @hResponseObj)

                  # create shortcuts to sections of internal object
                  hMetadata = intObj[:metadata]
                  hMetaInfo = hMetadata[:metadataInfo]
                  hResInfo = hMetadata[:resourceInfo]
                  aDistInfo = hMetadata[:distributorInfo]
                  version = @hResponseObj[:translatorVersion]

                  # document head
                  metadata = @xml.instruct! :xml, encoding: 'UTF-8'
                  @xml.comment!('ISO 19115-2 METADATA')
                  @xml.comment!('The following metadata file was constructed using the ADIwg mdTranslator, http://mdtranslator.adiwg.org')
                  @xml.comment!('mdTranslator software is an open-source project of the Alaska Data Integration working group (ADIwg)')
                  @xml.comment!('mdTranslator and other metadata tools are available at https://github.com/adiwg')
                  @xml.comment!('ADIwg is not responsible for the content of this metadata record')
                  @xml.comment!('This metadata record was generated by mdTranslator ' + version + ' at ' + Time.now.to_s)

                  # schema locations
                  # set to 'remoteSchema' before publishing
                  localSchema = 'C:\Users\StanSmith\Projects\ISO\19115\NOAA\schema.xsd'
                  remoteSchema = 'https://data.noaa.gov/resources/iso19139/schema.xsd'

                  # MI_Metadata
                  @xml.tag!('gmi:MI_Metadata',
                            {'xmlns:gmi' => 'http://www.isotc211.org/2005/gmi',
                             'xmlns:gmd' => 'http://www.isotc211.org/2005/gmd',
                             'xmlns:gco' => 'http://www.isotc211.org/2005/gco',
                             'xmlns:gml' => 'http://www.opengis.net/gml/3.2',
                             'xmlns:gsr' => 'http://www.isotc211.org/2005/gsr',
                             'xmlns:gss' => 'http://www.isotc211.org/2005/gss',
                             'xmlns:gst' => 'http://www.isotc211.org/2005/gst',
                             'xmlns:gmx' => 'http://www.isotc211.org/2005/gmx',
                             'xmlns:gfc' => 'http://www.isotc211.org/2005/gfc',
                             'xmlns:srv' => 'http://www.isotc211.org/2005/srv',
                             'xmlns:mdb' => 'http://www.isotc211.org/2005/mdb',
                             'xmlns:mdq' => 'http://www.isotc211.org/2005/mdq',
                             'xmlns:mcc' => 'http://www.isotc211.org/2005/mcc',
                             'xmlns:xlink' => 'http://www.w3.org/1999/xlink',
                             'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
                             'xsi:schemaLocation' => "http://www.isotc211.org/2005/gmi #{remoteSchema}"}) do

                     # metadata information - file identifier (default: UUID)
                     s = hMetaInfo[:metadataIdentifier][:identifier]
                     @xml.tag!('gmd:fileIdentifier') do
                        unless s.nil?
                           @xml.tag!('gco:CharacterString', s)
                        end
                        if s.nil?
                           @xml.tag!('gco:CharacterString', UUIDTools::UUID.random_create.to_s)
                        end
                     end

                     # metadata information - metadata language ('eng; USA')
                     @xml.tag!('gmd:language') do
                        @xml.tag!('gco:CharacterString', 'eng; USA')
                     end

                     # metadata information - metadata character ('utf-8')
                     @xml.tag!('gmd:characterSet') do
                        codelistClass.writeXML('gmd', 'iso_characterSet', 'UTF-8')
                     end

                     # metadata information - parent identifier
                     s = nil
                     hParent = hMetaInfo[:parentMetadata]
                     unless hParent.empty?
                        s = hParent[:title]
                     end
                     unless s.nil?
                        @xml.tag!('gmd:parentIdentifier') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:parentIdentifier')
                     end

                     # metadata information - hierarchy level [] {MD_scopeCode}
                     # metadata information - hierarchy level Name [] {string}
                     # hierarchy comes from resourceInfo < resourceType []
                     # pass entire array to hierarchy
                     # all hierarchyLevel tags must precede the hierarchyLevelName tags
                     aResTypes = hResInfo[:resourceTypes]
                     unless aResTypes.empty?
                        hierarchyClass.writeXML(aResTypes)
                     end
                     if aResTypes.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:hierarchyLevel')
                        @xml.tag!('gmd:hierarchyLevelName')
                     end

                     # metadata information - metadata contact [] (required)
                     # [{CI_ResponsibleParty}]
                     aRParties = hMetaInfo[:metadataContacts]
                     aRParties.each do |hRParty|
                        role = hRParty[:roleName]
                        aParties = hRParty[:parties]
                        aParties.each do |hParty|
                           @xml.tag!('gmd:contact') do
                              partyClass.writeXML(role, hParty, 'metadata contact')
                           end
                        end
                     end
                     if aRParties.empty?
                        @NameSpace.issueWarning(240, 'gmd:contact')
                     end

                     # metadata information - date stamp (required) {default: now()}
                     hCreateDate = {}
                     hCreateDate[:date] = DateTime.now
                     hCreateDate[:dateResolution] = 'YMD'
                     aDates = hMetaInfo[:metadataDates]
                     aDates.each do |hDate|
                        if hDate[:dateType] == 'creation'
                           hCreateDate = hDate
                        end
                     end
                     @xml.tag!('gmd:dateStamp') do
                        dateTimeClass.writeXML(hCreateDate)
                     end

                     # metadata information - metadata standard name (default)
                     @xml.tag!('gmd:metadataStandardName') do
                        @xml.tag!('gco:CharacterString', 'ISO 19139')
                     end

                     # metadata information - metadata standard version (default)
                     @xml.tag!('gmd:metadataStandardVersion') do
                        @xml.tag!('gco:CharacterString', 'ISO 19115-2:2009(E)')
                     end

                     # metadata information - metadata linkage
                     s = nil
                     unless hMetaInfo[:metadataLinkages].empty?
                        hLinkage = hMetaInfo[:metadataLinkages][0]
                        s = hLinkage[:olResURI]
                        @xml.tag!('gmd:dataSetURI') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:dataSetURI')
                     end

                     # metadata information - locale []
                     aLocales = hMetaInfo[:otherMetadataLocales]
                     unless hMetaInfo[:defaultMetadataLocale].empty?
                        aLocales.insert(0, hMetaInfo[:defaultMetadataLocale])
                     end
                     aLocales.each do |hLocale|
                        @xml.tag!('gmd:locale') do
                           localeClass.writeXML(hLocale, 'metadata information locale')
                        end
                     end
                     if aLocales.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:locale')
                     end

                     # metadata information - spatial representation []
                     aReps = hResInfo[:spatialRepresentations]
                     aReps.each do |hRep|
                        @xml.tag!('gmd:spatialRepresentationInfo') do
                           representationClass.writeXML(hRep)
                        end
                     end
                     if aReps.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:spatialRepresentationInfo')
                     end

                     # metadata information - reference system []
                     aSystems = hResInfo[:spatialReferenceSystems]
                     aSystems.each do |hSystem|
                        # reference systems with referenceType only are not supported in 19115-2
                        unless hSystem[:systemIdentifier].empty? && hSystem[:systemParameterSet].empty?
                           @xml.tag!('gmd:referenceSystemInfo') do
                              systemClass.writeXML(hSystem)
                           end
                        end
                     end
                     if aSystems.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:referenceSystemInfo')
                     end

                     # metadata information - metadata extension info
                     # add biological profile to all metadata records
                     intBio = intMetadataClass.newMetadataExtension
                     intBio[:name] = 'Taxonomy System'
                     intBio[:shortName] = 'TaxonSys'
                     intBio[:definition] = 'Documentation of taxonomic sources, procedures, and treatments'
                     intBio[:obligation] = 'optional'
                     intBio[:dataType] = 'class'
                     intBio[:maxOccurrence] = '1'
                     intBio[:parentEntities] << 'MD_Identification'
                     intBio[:rule] = 'New Metadata section as a class to MD_Identification'
                     intBio[:rationales] << 'The set of data elements contained within this class element ' +
                        'represents an attempt to provide better documentation of ' +
                        'taxonomic sources, procedures, and treatments.'
                     intBio[:sourceOrganization] = 'National Biological Information Infrastructure'
                     intBio[:sourceURI] = 'https://www2.usgs.gov/core_science_systems/Access/p1111-1.html'
                     intBio[:sourceRole] = 'author'

                     @xml.tag!('gmd:metadataExtensionInfo') do
                        extensionClass.writeXML(intBio)
                     end

                     # ###################### Begin Data Identification #####################

                     # metadata information - identification info - required
                     unless hResInfo.empty?
                        @xml.tag!('gmd:identificationInfo') do
                           dataIdClass.writeXML(hMetadata)
                        end
                     end
                     if hResInfo.empty?
                        @NameSpace.issueWarning(241, 'gmd:identificationInfo')
                     end

                     # ###################### End Data Identification #######################

                     # metadata information - coverageDescription []
                     aItems = hResInfo[:coverageDescriptions]
                     aItems.each do |hCoverage|

                        # mdJson follows ISO 19115-1 for this section
                        # in ISO 19115-1
                        # coverageDescription << attributeGroup << attribute (rangeDimension)
                        # in ISO 19115-2
                        # coverageDescription << attribute (rangeDimension)
                        # how to handle in ISO 19115-2 ...
                        # break up attributeGroup, handle each in separate coverageDescription
                        # handle image and attributeGroup in separate coverageDescriptions
                        # also allow both attributeGroup and imageDescription to be empty

                        if hCoverage[:imageDescription].empty? && hCoverage[:attributeGroups].empty?
                           @xml.tag!('gmd:contentInfo') do
                              coverageClass.writeXML(hCoverage)
                           end
                        end

                        unless hCoverage[:imageDescription].empty?
                           hInstance = Marshal::load(Marshal.dump(hCoverage))
                           hInstance[:attributeGroups] = []
                           @xml.tag!('gmd:contentInfo') do
                              coverageClass.writeXML(hInstance)
                           end
                        end

                        hCoverage[:attributeGroups].each do |hGroup|
                           hInstance = Marshal::load(Marshal.dump(hCoverage))
                           hInstance[:imageDescription] = {}
                           hInstance[:attributeGroups] = []
                           hInstance[:attributeGroups] << hGroup
                           @xml.tag!('gmd:contentInfo') do
                              coverageClass.writeXML(hInstance)
                           end
                        end

                     end
                     if aItems.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:contentInfo')
                     end

                     # metadata information - distribution info [0]
                     unless aDistInfo.empty?
                        hDistInfo = aDistInfo[0]
                        unless hDistInfo.empty?
                           @xml.tag!('gmd:distributionInfo') do
                              distClass.writeXML(hDistInfo)
                           end
                        end
                     end
                     if aDistInfo.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:distributionInfo')
                     end

                     # metadata information - data quality info []
                     aDQInfo = hMetadata[:lineageInfo]
                     aDQInfo.each do |hDQInfo|
                        @xml.tag!('gmd:dataQualityInfo') do
                           dqClass.writeXML(hDQInfo)
                        end
                     end
                     if aDQInfo.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:dataQualityInfo')
                     end

                     aDataQuality = hMetadata[:dataQuality]
                     aDataQuality.each do |hDataQuality|
                        unless hDataQuality.empty?
                           @xml.tag!('mdb:dataQualityInfo') do 
                              dqClass.writeXML(hDataQuality, dataQualityType: 'mdb')
                           end
                        end
                        if aDataQuality.empty? && @hResponseObj[:writeShowTags]
                           @xml.tag('mdb:dataQualityInfo')
                        end
                     end

                     # metadata information - metadata constraints {}
                     aCons = hMetaInfo[:metadataConstraints]
                     aCons.each do |hCon|
                        @xml.tag!('gmd:metadataConstraints') do
                           type = hCon[:type]
                           if type == 'use'
                              uConClass.writeXML(hCon)
                           end
                           if type == 'legal'
                              lConClass.writeXML(hCon)
                           end
                           if type == 'security'
                              sConClass.writeXML(hCon)
                           end
                        end
                     end
                     if aCons.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:metadataConstraints')
                     end

                     # metadata information - metadata maintenance
                     hMaintenance = hMetaInfo[:metadataMaintenance]
                     unless hMaintenance.empty?
                        @xml.tag!('gmd:metadataMaintenance') do
                           maintenanceClass.writeXML(hMaintenance, 'metadata maintenance')
                        end
                     end
                     if hMaintenance.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:metadataMaintenance')
                     end

                  end # gmi:MI_Metadata tag

                  return metadata

               end # writeXML
            end # MI_Metadata class

         end
      end
   end
end
