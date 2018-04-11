# ISO <<Class>> MD_Medium
# 19115-2 writer output in XML

# History:
#  Stan Smith 2016-11-30 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-09-15 added density, densityUnits elements
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-09-26 original script.

require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_Medium

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hMedium)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_Medium') do

                     # medium - name {MD_MediumNameCode}
                     hIdentifier = hMedium[:identifier]
                     s = nil
                     unless hIdentifier.empty?
                        s = hIdentifier[:identifier]
                        unless s.nil?
                           @xml.tag!('gmd:name') do
                              codelistClass.writeXML('gmd', 'iso_mediumName', s)
                           end
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:name')
                     end

                     # medium - density {MB}
                     s = hMedium[:density]
                     unless s.nil?
                        @xml.tag!('gmd:density') do
                           @xml.tag!('gco:Real', s.to_s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:density')
                     end

                     # medium density units
                     s = hMedium[:units]
                     unless s.nil?
                        s = s.downcase
                        @xml.tag!('gmd:densityUnits') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:densityUnits')
                     end

                     # medium - volumes
                     s = hMedium[:numberOfVolumes]
                     unless s.nil?
                        @xml.tag!('gmd:volumes') do
                           @xml.tag!('gco:Integer', s.to_s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:volumes')
                     end

                     # medium - medium format code [] {MD_MediumFormatCode}
                     aCode = hMedium[:mediumFormat]
                     aCode.each do |code|
                        @xml.tag!('gmd:mediumFormat') do
                           codelistClass.writeXML('gmd', 'iso_mediumFormat', code)
                        end
                     end
                     if aCode.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:mediumFormat')
                     end

                     # medium - note
                     s = hMedium[:note]
                     unless s.nil?
                        @xml.tag!('gmd:mediumNote') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:mediumNote')
                     end

                  end # gmd:MD_Medium
               end # writeXML
            end # MD_Medium class

         end
      end
   end
end
