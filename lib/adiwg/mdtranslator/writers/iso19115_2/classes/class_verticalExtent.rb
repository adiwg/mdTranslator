# ISO <<Class>> EX_VerticalExtent
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-10 add error and warning messaging
#  Stan Smith 2016-12-01 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-11-15 original script

require_relative '../iso19115_2_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class EX_VerticalExtent

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hVertEle)

                  @xml.tag!('gmd:EX_VerticalExtent') do

                     # vertical extent - minimum value (required)
                     s = hVertEle[:minValue]
                     if s.nil?
                        @NameSpace.issueWarning(330, 'gmd:minimumValue')
                     else
                        @xml.tag!('gmd:minimumValue') do
                           @xml.tag!('gco:Real', s)
                        end
                     end

                     # vertical extent - maximum value (required)
                     s = hVertEle[:maxValue]
                     if s.nil?
                        @NameSpace.issueWarning(331, 'gmd:maximumValue')
                     else
                        @xml.tag!('gmd:maximumValue') do
                           @xml.tag!('gco:Real', s)
                        end
                     end

                     # vertical extent - vertical crs (attributes only) (required)
                     attributes = {}
                     title = nil
                     href = nil
                     hSpaceRef = hVertEle[:crsId]
                     unless hSpaceRef.empty?
                        hIdentifier = hSpaceRef[:systemIdentifier]
                        unless hIdentifier.empty?
                           title = hIdentifier[:identifier]
                           href = hIdentifier[:namespace]
                           hCitation = hIdentifier[:citation]
                           unless hCitation.empty?
                              hOnline = hCitation[:onlineResources][0]
                              unless hOnline.empty?
                                 href = hOnline[:olResURI]
                              end
                           end
                        end
                     end
                     unless href.nil?
                        attributes['xlink:href'] = href
                     end
                     unless title.nil?
                        attributes['xlink:title'] = title
                     end
                     unless attributes.empty?
                        @xml.tag!('gmd:verticalCRS', attributes)
                     end
                     if attributes.empty?
                        @NameSpace.issueWarning(332, 'gmd:verticalCRS')
                     end

                  end # EX_VerticalExtent tag
               end # writeXML
            end # EX_VerticalExtent class

         end
      end
   end
end
