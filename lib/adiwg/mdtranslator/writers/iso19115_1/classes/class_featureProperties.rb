# GeoJSON Feature Properties
# 19115-1 writer output in XML

# History:
#   Stan Smith 2019-03-20 original script

require_relative 'class_gmlIdentifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class FeatureProperties

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hProperties)

                  # classes used
                  gmlId = GMLIdentifier.new(@xml, @hResponseObj)

                  unless hProperties.empty?

                     # feature properties - description
                     unless hProperties[:description].nil?
                        @xml.tag!('gml:description', hProperties[:description])
                     end
                     if hProperties[:description].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:description')
                     end

                     # feature properties - identifier [0]
                     unless hProperties[:identifiers].empty?
                        hId = hProperties[:identifiers][0]
                        gmlId.writeXML(hId)
                     end
                     if hProperties[:identifiers].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:identifier', {'codeSpace' => ''})
                     end

                     # feature properties - name []
                     hProperties[:featureNames].each do |name|
                        @xml.tag!('gml:name', name)
                     end
                     if hProperties[:featureNames].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gml:name')
                     end

                     # feature properties - featureScope - not supported
                     # feature properties - acquisitionMethod - not supported

                  end

               end # writeXML
            end # FeatureProperties class

         end
      end
   end
end
