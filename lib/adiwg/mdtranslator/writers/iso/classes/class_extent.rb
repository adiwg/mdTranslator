# ISO <<Class>> EX_Extent
# writer output in XML

# History:
# 	Stan Smith 2013-11-01 original script
# 	Stan Smith 2013-11-15 add temporal elements
# 	Stan Smith 2013-11-15 add vertical elements
#   Stan Smith 2014-05-29 changes for json schema version 0.5.0
#   Stan Smith 2014-05-29 ... added new class for geographicElement
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'class_geographicElement'
require 'class_geographicDescription'
require 'class_temporalExtent'
require 'class_verticalExtent'

class EX_Extent

    def initialize(xml)
        @xml = xml
    end

    def writeXML(hExtent)

        # classes used by MD_Metadata
        tempExtClass = EX_TemporalExtent.new(@xml)
        vertExtClass = EX_VerticalExtent.new(@xml)
        geoEleClass = GeographicElement.new(@xml)
        geoEleIdClass = EX_GeographicDescription.new(@xml)

        @xml.tag!('gmd:EX_Extent') do

            # extent - description
            s = hExtent[:extDesc]
            if !s.nil?
                @xml.tag!('gmd:description') do
                    @xml.tag!('gco:CharacterString', s)
                end
            elsif $showAllTags
                @xml.tag!('gmd:description')
            end

            # extent - geographic element - for geometry
            aGeoElements = hExtent[:extGeoElements]
            if !aGeoElements.empty?
                aGeoElements.each do |hGeoElement|
                    @xml.tag!('gmd:geographicElement') do
                        geoEleClass.writeXML(hGeoElement)
                    end
                end
            elsif $showAllTags
                @xml.tag!('gmd:geographicElement')
            end

            # extent - geographic element - for identifier
            aGeoElements = hExtent[:extIdElements]
            if !aGeoElements.empty?
                aGeoElements.each do |hGeoElement|
                    @xml.tag!('gmd:geographicElement') do
                        geoEleIdClass.writeXML(hGeoElement)
                    end
                end
            end

            # extent - temporal element
            aTempElements = hExtent[:extTempElements]
            if !aTempElements.empty?
                aTempElements.each do |hTempElement|
                    @xml.tag!('gmd:temporalElement') do
                        tempExtClass.writeXML(hTempElement)
                    end
                end
            elsif $showAllTags
                @xml.tag!('gmd:temporalElement')
            end

            # extent - vertical element
            aVertElements = hExtent[:extVertElements]
            if !aVertElements.empty?
                aVertElements.each do |hVertElement|
                    @xml.tag!('gmd:verticalElement') do
                        vertExtClass.writeXML(hVertElement)
                    end
                end
            elsif $showAllTags
                @xml.tag!('gmd:verticalElement')
            end
        end

    end

end