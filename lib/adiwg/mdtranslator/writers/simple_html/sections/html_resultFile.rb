# HTML writer
# result file

require_relative 'html_format'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_ResultFile

               def initialize(html)
                  @html = html
               end

               def writeHtml(hResultFile)

                  # classes used
                  formatClass = Html_Format.new(@html)

                  
                  # result file - file name
                  unless hResultFile[:fileName].nil?
                    @html.em('File Name: ')
                    @html.text!(hResultFile[:fileName])
                    @html.br
                  end

                  # result file - file type
                  unless hResultFile[:fileType].nil?
                    @html.em('File Type: ')
                    @html.text!(hResultFile[:fileType])
                    @html.br
                 end

                 # result file - file description
                 unless hResultFile[:fileDescription].nil?
                    @html.em('File Description: ')
                    @html.text!(hResultFile[:fileDescription])
                    @html.br
                 end

                 # result file - file format
                 unless hResultFile[:fileFormat].empty?
                    @html.details do
                       @html.div(hResultFile[:fileFormat][:title], {'class' => 'h5'})
                       @html.div(:class => 'block') do
                          formatClass.writeHtml(hResultFile[:fileFormat])
                       end
                    end
                 end

               end # writeHtml
            end # Html_ResultFile

         end
      end
   end
end
