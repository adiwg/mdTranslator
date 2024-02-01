# HTML writer
# distribution

# History:
#  Stan Smith 2018-01-29 add liabilityStatement
# 	Stan Smith 2017-04-04 original script

require_relative 'html_distributor'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Distribution

               def initialize(html)
                  @html = html
               end

               def writeHtml(hDistribution)

                  # classes used
                  distributorClass = Html_Distributor.new(@html)

                  # distribution - description
                  unless hDistribution[:description].nil?
                     @html.em('Description:')
                     @html.div(:class => 'block') do
                        @html.text!(hDistribution[:description])
                     end
                  end

                  # distribution - liability statement
                  unless hDistribution[:liabilityStatement].nil?
                     @html.em('Liability Statement:')
                     @html.div(:class => 'block') do
                        @html.text!(hDistribution[:liabilityStatement])
                     end
                  end

                  # distribution - distributor [] {distributor}
                  hDistribution[:distributor].each do |hDistributor|
                     @html.div do
                        @html.h5('Distributor', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           distributorClass.writeHtml(hDistributor)
                        end
                     end
                  end

               end # writeHtml
            end # Html_Distribution

         end
      end
   end
end
