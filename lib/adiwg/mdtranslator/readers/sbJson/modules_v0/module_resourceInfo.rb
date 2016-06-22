# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_citation')
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_responsibleParty')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_resourceFormat')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_descriptiveKeyword')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_resourceMaintenance')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_resourceSpecificUsage')
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_browseGraphic')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_legalConstraint')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_securityConstraint')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_taxonomy')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_resolution')
require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_extent')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_dataQuality')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_spatialReference')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_timePeriod')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_locale')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_gridInfo')
# require ADIWG::Mdtranslator::Readers::SbJson.readerModule('module_coverageInfo')
require 'uri'

module ADIWG
    module Mdtranslator
        module Readers
            module SbJson
                module ResourceInfo
                    def self.unpack(hResourceInfo, responseObj, intObj)
                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intResInfo = intMetadataClass.newResourceInfo

                        # resource information - resource type
                        # we can check for the project "facet",
                        # however there is no reliable way to determine
                        # other types so just default to "dataset"
                        if hResourceInfo.key?('facets')
                            projectFacet = hResourceInfo['facets'].find { |s| s['className'] == 'gov.sciencebase.catalog.item.facet.ProjectFacet' }
                        end
                        intResInfo[:resourceType] = projectFacet.nil? ? 'dataset' : 'project'

                        # resource information - citation
                        hCitation = intMetadataClass.newCitation
                        hCitation[:citTitle] = hResourceInfo['title']
                        if hResourceInfo.key?('alternateTitles')
                            hCitation[:citAltTitle] = hResourceInfo['alternateTitles'][0]
                        end

                        pId = intMetadataClass.newResourceId
                        pId[:identifier] = hResourceInfo['id']
                        pId[:identifierType] = 'uuid'
                        pId[:identifierNamespace] = 'gov.sciencebase.catalog'
                        pId[:identifierDescription] = 'The unique ScienceBase id of the parent resource.'
                        hCitation[:citResourceIds] << pId

                        if hResourceInfo.key?('identifiers')
                            hResourceInfo['identifiers'].each do |id|
                                pId = intMetadataClass.newResourceId
                                pId[:identifier] = id['key']
                                pId[:identifierType] = id['type']
                                pId[:identifierNamespace] = id['scheme']
                                hCitation[:citResourceIds] << pId
                            end
                        end

                        # citation - presentation form
                        if hResourceInfo.key?('browseTypes')
                            aPForms = hResourceInfo['browseTypes']
                            unless aPForms.empty?
                                aPForms.each do |pForm|
                                    hCitation[:citResourceForms] << pForm
                                end
                            end
                        end

                        if hResourceInfo.key?('contacts')
                            hResourceInfo['contacts'].each do |contact|
                                aCont = {}
                                aCont[:contactId] = contact['contactId']
                                aCont[:roleName] = contact['type']
                                hCitation[:citResponsibleParty] << aCont
                            end
                        end

                        if hResourceInfo.key?('dates')
                            hResourceInfo['dates'].each do |date|
                                s = date['dateString']
                                next unless s != ''
                                hDateTime = DateTime.unpack(s, responseObj)
                                hDateTime[:dateType] = date['type']
                                hCitation[:citDate] << hDateTime
                            end
                        end

                        if hResourceInfo.key?('link')
                            link = hResourceInfo['link']
                            intOLRes = intMetadataClass.newOnlineResource
                            intOLRes[:olResURI] = link['url']
                            intOLRes[:olResProtocol] = 'http'
                            intOLRes[:olResName] = 'Resource Link'
                            intOLRes[:olResDesc] = 'ScienceBase URL of resource'
                            intOLRes[:olResFunction] = 'information'
                            hCitation[:citOlResources] << intOLRes
                        end

                        unless hCitation.empty?
                            intResInfo[:citation] = hCitation
                        end

                        # resource information - resource time period
                        # if hResourceInfo.has_key?('resourceTimePeriod')
                        #     hResPeriod = hResourceInfo['resourceTimePeriod']
                        #     unless hResPeriod.empty?
                        #         intResInfo[:timePeriod] = TimePeriod.unpack(hResPeriod, responseObj)
                        #     end
                        # end

                        # resource information - point of contact
                        # metadata - metadata contacts, custodians
                        # We're just injecting the first sbJSON contact here
                        firstCont = intObj[:contacts][0]
                        aCust = {}
                        aCust['contactId'] = firstCont[:contactId]
                        aCust['role'] = firstCont[:primaryRole]
                        intResInfo[:pointsOfContact] << ResponsibleParty.unpack(aCust, responseObj)

                        # resource information - abstract
                        if hResourceInfo.key?('body')
                            s = hResourceInfo['body']
                            intResInfo[:abstract] = s if s != ''
                        end

                        # resource information - short abstract
                        if hResourceInfo.key?('summary')
                            s = hResourceInfo['summary']
                            intResInfo[:shortAbstract] = s if s != ''
                        end

                        # resource information - status
                        # project status is sometimes available
                        # otherwise just defaults to "published"
                        if projectFacet.nil?

                            if hResourceInfo.key?('status')
                                s = hResourceInfo['status']
                            end
                            intResInfo[:status] = s.nil? ? 'published' : s
                        end

                        # resource information - has mappable location
                        intResInfo[:hasMapLocation?] = hResourceInfo.key?('spatial')

                        # resource information - has data available
                        intResInfo[:hasDataAvailable?] = hResourceInfo.key?('distributionLinks')

                        # resource information - language
                        intResInfo[:resourceLanguages] << 'eng'

                        # resource information - characterSet [] - default 'utf8'
                        intResInfo[:resourceCharacterSets] << 'UTF-8'

                        # resource - locale
                        intLocale = intMetadataClass.newLocale
                        intLocale[:languageCode] = 'eng'
                        intLocale[:countryCode] = 'USA'
                        intLocale[:characterEncoding] = 'UTF-8'
                        intResInfo[:resourceLocales] << intLocale

                        # resource information - purpose
                        if hResourceInfo.key?('purpose')
                            s = hResourceInfo['purpose']
                            intResInfo[:purpose] = s if s != ''
                        end

                        # resource information - credit
                        if hResourceInfo.key?('citation')
                            aCredits = hResourceInfo['citation']
                            intResInfo[:credits] << aCredits
                        end

                        # resource information - topic category
                        if hResourceInfo.key?('tags')
                            tags = hResourceInfo['tags'].group_by { |t| t['scheme'] || 'None' }
                            aTopics = tags['ISO 19115 Topic Categories']
                            unless aTopics.nil?
                                aTopics.each do |topic|
                                    intResInfo[:topicCategories] << topic['name']
                                end
                            end
                        end

                        # resource information - environment description
                        # if hResourceInfo.has_key?('environmentDescription')
                        #     s = hResourceInfo['environmentDescription']
                        #     if s != ''
                        #         intResInfo[:environmentDescription] = s
                        #     end
                        # end

                        # resource information - resource format
                        # if hResourceInfo.has_key?('resourceNativeFormat')
                        #     aResFormat = hResourceInfo['resourceNativeFormat']
                        #     unless aResFormat.empty?
                        #         aResFormat.each do |hResFormat|
                        #             intResInfo[:resourceFormats] << ResourceFormat.unpack(hResFormat, responseObj)
                        #         end
                        #     end
                        # end

                        # resource information - descriptive keywords
                        unless tags.nil?
                            aDesKeywords = tags.select { |t| t != 'ISO 19115 Topic Categories' }
                            unless aDesKeywords.empty?
                                aDesKeywords.each do |k, kScheme|
                                    kType = kScheme.group_by { |t| t['type'] || 'Theme' }

                                    kType.each do |type, words|
                                        intKw = intMetadataClass.newKeyword
                                        intKw[:keywordType] = type
                                        words.each do |kw|
                                            intKw[:keyword] << kw['name']
                                        end
                                        kCitation = intMetadataClass.newCitation
                                        kCitation[:citTitle] = 'ScienceBase Tags'
                                        pParty = intMetadataClass.newRespParty
                                        pParty[:contactId] = 'SB'
                                        pParty[:roleName] = 'publisher'
                                        kCitation[:citResponsibleParty] << pParty
                                        if k =~ /\A#{URI.regexp(%w(http https))}\z/
                                            intOLRes = intMetadataClass.newOnlineResource
                                            intOLRes[:olResURI] = k
                                            intOLRes[:olResProtocol] = 'http'
                                            intOLRes[:olResName] = 'Link to ScienceBase scheme'
                                            intOLRes[:olResDesc] = ' ScienceBase controlled vocabulary'
                                            intOLRes[:olResFunction] = 'information'
                                            kCitation[:citOlResources] << intOLRes
                                        end
                                        intKw[:keyTheCitation] = kCitation
                                        intResInfo[:descriptiveKeywords] << intKw
                                    end
                                end
                            end
                        end

                        # resource information - resource maintenance
                        # if hResourceInfo.has_key?('resourceMaintenance')
                        #     aResMaint = hResourceInfo['resourceMaintenance']
                        #     unless aResMaint.empty?
                        #         aResMaint.each do |hResource|
                        #             intResInfo[:resourceMaint] << ResourceMaintenance.unpack(hResource, responseObj)
                        #         end
                        #     end
                        # end

                        # resource information - resource specific usage
                        # if hResourceInfo.key?('resourceSpecificUsage')
                        #     aResUses = hResourceInfo['resourceSpecificUsage']
                        #     unless aResUses.empty?
                        #         aResUses.each do |hUsage|
                        #             intResInfo[:resourceUses] << ResourceSpecificUsage.unpack(hUsage, responseObj)
                        #         end
                        #     end
                        # end

                        # resource information - graphic overview
                        if hResourceInfo.key?('previewImage')
                            aBrowseGraph = hResourceInfo['previewImage']

                            unless aBrowseGraph.empty?
                                aBrowseGraph.each_pair do |name, bg|
                                    next unless bg.is_a?(Hash)

                                    hb = {
                                        'fileName' => name,
                                        'fileDescription' => 'Preview image.',
                                        'fileType' => 'image',
                                        'fileUri' => bg['uri']
                                    }
                                    intResInfo[:graphicOverview] << BrowseGraphic.unpack(hb, responseObj)
                                end
                            end
                        end

                        # resource information - use constraints
                        # if hResourceInfo.key?('constraint')
                        #     hConstraint = hResourceInfo['constraint']

                        # resource information - resource constraints - use
                        # if hConstraint.key?('useLimitation')
                        #     aUseLimits = hConstraint['useLimitation']
                        #     unless aUseLimits.empty?
                        #         aUseLimits.each do |useLimit|
                        #             intResInfo[:useConstraints] << useLimit
                        #         end
                        #     end
                        # end

                        # resource information - resource constraints - legal
                        if hResourceInfo.key?('rights')
                            aLegalCons = hResourceInfo['rights']
                            unless aLegalCons.empty?
                                aCons = intMetadataClass.newLegalConstraint
                                aCons[:useCodes] <<  aLegalCons
                                intResInfo[:legalConstraints] << aCons
                            end
                        end

                        # resource information - resource constraints - security
                        # if hConstraint.key?('securityConstraint')
                        #     aSecurityCons = hConstraint['securityConstraint']
                        #     unless aSecurityCons.empty?
                        #         aSecurityCons.each do |hSecurityCon|
                        #             intResInfo[:securityConstraints] << SecurityConstraints.unpack(hSecurityCon, responseObj)
                        #         end
                        #     end
                        # end

                        # end

                        # # resource information - taxonomy
                        # if hResourceInfo.has_key?('taxonomy')
                        #     hTaxonomy = hResourceInfo['taxonomy']
                        #     unless hTaxonomy.empty?
                        #         intResInfo[:taxonomy] = Taxonomy.unpack(hTaxonomy, responseObj)
                        #     end
                        # end

                        # resource information - spatial reference systems
                        # if hResourceInfo.key?('spatialReferenceSystem')
                        #     hSpatialRef = hResourceInfo['spatialReferenceSystem']
                        #     unless hSpatialRef.empty?
                        #         intResInfo[:spatialReferenceSystem] = SpatialReferenceSystem.unpack(hSpatialRef, responseObj)
                        #     end
                        # end
                        #
                        # # resource information - spatial representation type
                        # if hResourceInfo.key?('spatialRepresentation')
                        #     aSpatialType = hResourceInfo['spatialRepresentation']
                        #     unless aSpatialType.empty?
                        #         aSpatialType.each do |spType|
                        #             intResInfo[:spatialRepresentationTypes] << spType
                        #         end
                        #     end
                        # end

                        # resource information - spatial resolution
                        # if hResourceInfo.has_key?('spatialResolution')
                        #     aSpRes = hResourceInfo['spatialResolution']
                        #     unless aSpRes.empty?
                        #         aSpRes.each do |hResolution|
                        #             intResInfo[:spatialResolutions] << Resolution.unpack(hResolution, responseObj)
                        #         end
                        #     end
                        # end

                        # resource information - extent
                        if hResourceInfo.key?('spatial')
                            aExtents = []
                            bbox = hResourceInfo['spatial']['boundingBox']
                            unless bbox.nil?
                                aExtents << {
                                    'description' => 'Spatial extent for Resource',
                                    'geographicElement' => [
                                        {
                                            'type' => 'Feature',
                                            'id' => 'boundingBox',
                                            'bbox' => [
                                                bbox['minX'],
                                                bbox['minY'],
                                                bbox['maxX'],
                                                bbox['maxY']
                                            ],
                                            'crs' => {
                                                'type' => 'name',
                                                'properties' => {
                                                    'name' => 'EPSG:4326'
                                                }
                                            },
                                            'geometry' => nil,
                                            'properties' => {
                                                'featureName' => 'Bounding box',
                                                'description' => 'bounding box for resource'
                                            }
                                        }
                                    ]
                                }
                            end
                            unless aExtents.empty?
                                aExtents.each do |hExtent|
                                    intResInfo[:extents] << Extent.unpack(hExtent, responseObj)
                                end
                            end
                        end

                        # # resource information - grid information
                        # if hResourceInfo.has_key?('gridInfo')
                        #     aGrids = hResourceInfo['gridInfo']
                        #     unless aGrids.empty?
                        #         aGrids.each do |hGrid|
                        #             intResInfo[:gridInfo] << GridInfo.unpack(hGrid, responseObj)
                        #         end
                        #     end
                        # end
                        #
                        # # resource information - coverage information
                        # if hResourceInfo.has_key?('coverageInfo')
                        #     aCoverage = hResourceInfo['coverageInfo']
                        #     unless aCoverage.empty?
                        #         aCoverage.each do |hCoverage|
                        #             intResInfo[:coverageInfo] << CoverageInfo.unpack(hCoverage, responseObj)
                        #         end
                        #     end
                        # end
                        #
                        # # resource information - data quality information
                        # if hResourceInfo.has_key?('dataQualityInfo')
                        #     aDataQual = hResourceInfo['dataQualityInfo']
                        #     unless aDataQual.empty?
                        #         aDataQual.each do |hDQ|
                        #             intResInfo[:dataQualityInfo] << DataQuality.unpack(hDQ, responseObj)
                        #         end
                        #     end
                        # end

                        # # resource information - supplemental info
                        # if hResourceInfo.has_key?('supplementalInfo')
                        #     s = hResourceInfo['supplementalInfo']
                        #     if s != ''
                        #         intResInfo[:supplementalInfo] = s
                        #     end
                        # end

                        intResInfo
                    end
                end
            end
        end
    end
end
