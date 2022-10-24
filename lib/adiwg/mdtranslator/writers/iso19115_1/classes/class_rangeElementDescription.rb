# ISO <<Class>> MI_RangeElementDescription attributes
# 19115-1 writer output in XML

require_relative '../iso19115_1_writer'

module ADIWG
  module Mdtranslator
    module Writers
      module Iso19115_1

        class MI_RangeElementDescription

          def initialize(xml, hResponseObj)
            @xml = xml
            @hResponseObj = hResponseObj
            @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
          end

          def writeXML(hAttribute, inContext = nil)

            unless hAttribute[:name].nil?
              @xml.tag!('mrc:name') do
                @xml.tag!('gco:CharacterString', hAttribute[:name])
              end
            end

            unless hAttribute[:definition].nil?
              @xml.tag!('mrc:definition') do
                @xml.tag!('gco:CharacterString', hAttribute[:definition])
              end
            end

            hAttribute[:rangeElements].each do |hRangeElement|
              @xml.tag!('mrc:rangeElement') do
                @xml.tag!('gco:Record') do
                  @xml.tag!('gco:CharacterString', hRangeElement)
                end
              end
            end
          end
        end
      end
    end
  end
end
