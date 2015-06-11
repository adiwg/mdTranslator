# Writer - internal data structure to ISO 19115-2:2009

# History:
# 	Stan Smith 2013-08-10 original script
#   Stan Smith 2014-06-04 add internal object pre-scan to create extents
#   ... for geometry supplemental information
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../iso/classes'))

require 'builder'
require 'date'
require 'uuidtools'
require 'adiwg/mdtranslator/writers/iso19115_2/class_MImetadata'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                def self.startWriter(internalObj)

                    # reset ISO id='' counter
                    $idCount = '_000'

                    # set the format of the output file based on the writer specified
                    $response[:writerFormat] = 'xml'
                    $response[:writerVersion] = ADIWG::Mdtranslator::VERSION

                    # pre-scan the internal object to create a new extents for each geometry
                    # ... that has supplemental information (temporal, vertical, identity).
                    # ... the new extents will be added to internalObj
                    prescanGeoElements(internalObj)

                    # create new XML document
                    xml = Builder::XmlMarkup.new(indent: 3)
                    metadataWriter = $WriterNS::MI_Metadata.new(xml)
                    metadata = metadataWriter.writeXML(internalObj)

                    # set writer pass to true if no writer modules set it to false
                    # false or warning will be set by code that places the message
                    # load metadata into $response
                    if $response[:writerPass].nil?
                        $response[:writerPass] = true
                    end

                    return metadata
                end

                def self.prescanGeoElements(internalObj)
                    # supplemental information for the geographic element is carried in the
                    # ... internal structure in the temporalElements:, verticalElements:,
                    # ... and elementIdentifiers: attributes of the extGeoElements:
                    # ... of the extent.
                    # since temporal, vertical, and identify information in ISO is a property
                    # ... of EX_Extent and not of the geographicElement,
                    # ... this code creates a new extent for each geographicElement
                    # ... that has supplemental information and
                    # ... moves the supplemental information from the geometry to the new extent.
                    # In this implementation, supplemental information is only allowed for
                    # ... geometry types of Point, LineString, and Polygon
                    aExtents = internalObj[:metadata][:resourceInfo][:extents]
                    unless aExtents.empty?
                        aExtents.each do |hExtent|
                            aGeoElements = hExtent[:extGeoElements]
                            unless aGeoElements.empty?
                                aGeoElements.each do |hGeoElement|
                                    hGeometry = hGeoElement[:elementGeometry]
                                    unless hGeometry.empty?
                                        geoType = hGeometry[:geoType]
                                        case geoType
                                            when 'Point', 'LineString', 'Polygon'
                                                newExtent = extentFromGeoElement(hGeoElement, geoType)
                                                if !newExtent.nil?
                                                    aExtents << newExtent
                                                end

                                            when 'MultiGeometry'
                                                aGeoMembers = hGeometry[:geometry]
                                                unless aGeoMembers.empty?
                                                    aGeoMembers.each do |hGeoMemberElement|
                                                        hGeometry = hGeoMemberElement[:elementGeometry]
                                                        unless hGeometry.empty?
                                                            geoType = hGeometry[:geoType]
                                                            case geoType
                                                                when 'Point', 'LineString', 'Polygon'
                                                                    newExtent = extentFromGeoElement(hGeoMemberElement, geoType)
                                                                    if !newExtent.nil?
                                                                        aExtents << newExtent
                                                                    end
                                                            end
                                                        end
                                                    end
                                                end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end

                def self.extentFromGeoElement(hGeoElement, geoType)
                    # build new extent to portray supplemental information
                    # from elementGeometry
                    if !hGeoElement[:temporalElements].empty? ||
                        !hGeoElement[:verticalElements].empty? ||
                            !hGeoElement[:elementIdentifiers].empty?

                        # get unique id for geometry
                        # if geometry id was missing, set it at this time so
                        # ... it will match the supplemental information extent description
                        geoID = hGeoElement[:elementId]
                        if geoID.nil?
                            $idCount = $idCount.succ
                            geoID = geoType + $idCount
                            hGeoElement[:elementId] = geoID
                        end

                        # build unique id for extent geometry
                        $idCount = $idCount.succ
                        extGeoID = geoType + $idCount

                        intMetadataClass = InternalMetadata.new
                        intExtent = intMetadataClass.newExtent
                        intGeoEle = intMetadataClass.newGeoElement

                        intGeoEle[:elementId] = extGeoID
                        intGeoEle[:elementGeometry] = hGeoElement[:elementGeometry]

                        intExtent[:extDesc] = 'Supplemental information for ' + geoID
                        intExtent[:extGeoElements] << intGeoEle
                        intExtent[:extIdElements] = hGeoElement[:elementIdentifiers]
                        intExtent[:extTempElements] = hGeoElement[:temporalElements]
                        intExtent[:extVertElements] = hGeoElement[:verticalElements]

                        return intExtent

                    else
                        return nil
                    end

                end

            end

        end
    end
end




