# HTML writer

# History:
#   Stan Smith 2017-03-22 refactor for mdTranslator 2.0
#   Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#   Stan Smith 2015-06-23 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-04-07 replaced instruct! with declare! and html to
#      ... conform with w3 html encoding declarations
#   Stan Smith 2015-03-23 original script

require_relative 'html_head'
require_relative 'html_body'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Document
               def initialize(html, intObj)
                  @html = html
                  @intObj = intObj
               end

               def writeHtml(cssLink)

                  # classes used
                  htmlHead = Head.new(@html)
                  htmlBody = Body.new(@html)

                  # write the html document
                  metadata = @html.declare! :DOCTYPE, :html
                  @html.html(:lang => 'en') do
                     htmlHead.writeHtml(cssLink)
                     htmlBody.writeHtml(@intObj)
                  end

                  return metadata

               end

               # find contact in contact array and return the contact hash
               def self.getContact(contactId)

                  @intObj[:contacts].each do |hCont|
                     if hCont[:contactId] == contactId
                        return hCont
                     end
                  end
                  return {}

               end

            end # Document

         end
      end
   end
end