# HTML writer
# citation

# History:
#  Stan Smith 2017-03-23 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-23 original script
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#  Stan Smith 2015-08-26 added alternate title

# require_relative 'html_dateTime'
# require_relative 'html_identifier'
# require_relative 'html_responsibleParty'
# require_relative 'html_onlineResource'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Citation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hCitation)

                  # classes used
                  # htmlDateTime = MdHtmlDateTime.new(@html)
                  # htmlResId = MdHtmlResourceId.new(@html)
                  # htmlResParty = MdHtmlResponsibleParty.new(@html)
                  # htmlOlRes = MdHtmlOnlineResource.new(@html)

                  # citation - title - required
                  @html.em('Title: ')
                  @html.text!(hCitation[:title])
                  @html.br

                  # # citation - alternate title
                  # s = hCitation[:citAltTitle]
                  # if s
                  #    @html.em('Alternate title: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # citation - date
                  # aDates = hCitation[:citDate]
                  # aDates.each do |hDatetime|
                  #    @html.em('Date: ')
                  #    htmlDateTime.writeHtml(hDatetime)
                  # end
                  #
                  # # citation - edition
                  # s = hCitation[:citEdition]
                  # if s
                  #    @html.em('Edition: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # citation - resource ids - resource identifier
                  # aIds = hCitation[:citResourceIds]
                  # aIds.each do |hId|
                  #    htmlResId.writeHtml(hId)
                  # end
                  #
                  # # citation - responsible parties
                  # aResPart = hCitation[:citResponsibleParty]
                  # if !aResPart.empty?
                  #    @html.em('Responsible party: ')
                  #    @html.section(:class => 'block') do
                  #       aResPart.each do |hParty|
                  #          htmlResParty.writeHtml(hParty)
                  #       end
                  #    end
                  # end
                  #
                  # # citation - presentation forms
                  # aForms = hCitation[:citResourceForms]
                  # aForms.each do |form|
                  #    @html.em('Resource form: ')
                  #    @html.text!(form)
                  #    @html.br
                  # end
                  #
                  # # citation - online resources
                  # aOlRes = hCitation[:citOlResources]
                  # aOlRes.each do |hOlRes|
                  #    @html.em('Online resource: ')
                  #    @html.section(:class => 'block') do
                  #       htmlOlRes.writeHtml(hOlRes)
                  #    end
                  # end

                  # TODO refactored to this point
                  @html.h2('Hi -- You refactored to this point in citation!!')

               end # writeHtml

            end # class

         end
      end
   end
end
