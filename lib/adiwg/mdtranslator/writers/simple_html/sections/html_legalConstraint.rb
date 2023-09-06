# HTML writer
# legal constraint

# History:
#  Stan Smith 2017-03-31 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-25 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_LegalConstraint

               def initialize(html)
                  @html = html
               end

               def writeHtml(hLegalCon)

                  # legal constraint - access constraints {restrictionCode}
                  hLegalCon[:accessCodes].each do |constraint|
                     @html.em('Access Constraint: ')
                     @html.text!(constraint)
                     @html.br
                  end

                  # legal constraint - use constraints {restrictionCode}
                  hLegalCon[:useCodes].each do |constraint|
                     @html.em('Use Constraint: ')
                     @html.text!(constraint)
                     @html.br
                  end

                  # legal constraint - other constraints
                  hLegalCon[:otherCons].each do |constraint|
                     @html.em('Other Constraint: ')
                     @html.div(:class => 'block') do
                        @html.text!(constraint)
                     end
                  end

               end # writeHtml
            end # Html_LegalConstraint

         end
      end
   end
end
