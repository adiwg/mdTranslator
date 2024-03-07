require_relative '../iso19115_3_writer'
require_relative 'class_format'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class QualityResultFile

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hResultFile, inContext = nil)

                  # classes used
                  formatClass = MD_Format.new(@xml, @hResponseObj)

                  @xml.tag!('mdq:QualityResultFile') do

                     unless hResultFile[:fileName].nil?
                        @xml.tag!('mdq:fileName') do
                           @xml.tag!('gcx:FileName', hResultFile[:fileName])
                        end
                     end

                     unless hResultFile[:fileType].nil?
                        @xml.tag!('mdq:fileType') do
                           @xml.tag!('gcx:MimeFileType', {:type => hResultFile[:fileType]})
                        end
                     end

                     unless hResultFile[:fileDescription].nil?
                        @xml.tag!('mdq:fileDescription') do
                            @xml.tag!('gco:CharacterString', hResultFile[:fileDescription])
                        end
                     end

                     unless hResultFile[:fileFormat].empty?
                        @xml.tag!('mdq:fileFormat') do
                           formatClass.writeXML(hResultFile[:fileFormat], inContext)
                        end
                     end

                  end 
               end # writeXML
            end 

         end
      end
   end
end
