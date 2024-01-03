# HTML writer
# range element description

module ADIWG
  module Mdtranslator
    module Writers
      module Simple_html

        class Html_RangeElementDescription

          def initialize(html)
            @html = html
          end

          def writeHtml(red)
            unless red[:name].nil?
              @html.em('Name:')
              @html.text!(red[:name])
              @html.br
            end

            unless red[:definition].nil?
              @html.em('Definition:')
              @html.text!(red[:definition])
              @html.br
            end

            red[:rangeElement].each do |hRangeElement|
              @html.em('Range Element:')
              @html.text!(hRangeElement)
            end

            @html.br
          end # writeHtml
        end # Html_RangeElementDescription
        
      end
    end
  end
end
