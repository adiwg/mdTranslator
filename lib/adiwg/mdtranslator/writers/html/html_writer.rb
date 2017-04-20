# Writer - html metadata writer

# History:
#  Stan Smith 2017 03-21 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#  Stan Smith 2015-06-23 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-01-28 original script

require 'builder'
require_relative 'version'
require_relative 'sections/html_document'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            def self.startWriter(intObj, responseObj)

               # set the format and version of the output file
               responseObj[:writerFormat] = 'html'
               responseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::Html::VERSION

               # create new HTML document
               html = Builder::XmlMarkup.new(indent: 3)
               # metadataWriter = MdHtmlWriter.new(html, intObj, paramsObj)
               htmlDocument = Html_Document.new(html, intObj)
               metadata = htmlDocument.writeHtml(responseObj)

               # set writer pass to true if no messages
               # false or warning will be set by code that places the message
               if responseObj[:writerMessages].empty?
                  responseObj[:writerPass] = true
               end

               return metadata

            end # startWriter

         end
      end
   end
end

