# HTML writer
# resource information

# History:
#  Stan Smith 2017-03-25 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-24 original script

require_relative 'html_resourceType'
require_relative 'html_citation'
require_relative 'html_usage'
require_relative 'html_responsibility'
require_relative 'html_temporalExtent'
require_relative 'html_duration'
require_relative 'html_spatialReference'
require_relative 'html_spatialRepresentation'
require_relative 'html_resolution'
require_relative 'html_keyword'
require_relative 'html_taxonomy'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_ResourceInfo

               def initialize(html)
                  @html = html
               end

               def writeHtml(hResource)

                  # classes used
                  typeClass = Html_ResourceType.new(@html)
                  citationClass = Html_Citation.new(@html)
                  usageClass = Html_Usage.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)
                  temporalClass = Html_TemporalExtent.new(@html)
                  durationClass = Html_Duration.new(@html)
                  sRefClass = Html_SpatialReference.new(@html)
                  sRepClass = Html_SpatialRepresentation.new(@html)
                  resolutionClass = Html_Resolution.new(@html)
                  keywordClass = Html_Keyword.new(@html)
                  taxonomyClass = Html_Taxonomy.new(@html)

                  # resource - type [] {resourceType}
                  hResource[:resourceTypes].each do |hType|
                     typeClass.writeHtml(hType)
                  end

                  # resource - status []
                  hResource[:status].each do |status|
                     @html.em('Status:')
                     @html.text!(status)
                     @html.br
                  end

                  # resource - citation {citation}
                  unless hResource[:citation].empty?
                     @html.details do
                        @html.summary('Citation', {'id' => 'resourceInfo-citation', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hResource[:citation])
                        end
                     end
                  end

                  # resource - abstract
                  unless hResource[:abstract].nil? && hResource[:shortAbstract].nil?
                     @html.details do
                        @html.summary('Abstract', {'id' => 'resourceInfo-abstract', 'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # short abstract
                           unless hResource[:shortAbstract].nil?
                              @html.em('Short Abstract:')
                              @html.br
                              @html.text!(hResource[:shortAbstract])
                              @html.br
                              @html.br
                           end

                           # full abstract
                           @html.em('Full Abstract:')
                           @html.br
                           @html.text!(hResource[:abstract])

                        end
                     end
                  end

                  # resource - purpose
                  unless hResource[:purpose].nil? && hResource[:resourceUsages].empty?
                     @html.details do
                        @html.summary('Purpose, Usage, and Limitations', {'id' => 'resourceInfo-purpose', 'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # purpose
                           unless hResource[:purpose].nil?
                              @html.em('Purpose:')
                              @html.br
                              @html.text!(hResource[:purpose])
                              @html.br
                           end

                           # usage and limitation
                           unless hResource[:resourceUsages].empty?
                              useCount = 0
                              hResource[:resourceUsages].each do |hUsage|
                                 useCount += 1
                                 @html.details do
                                    @html.summary('Usage and Limitation '+useCount.to_s, {'class' => 'h5'})
                                    @html.section(:class => 'block') do
                                       usageClass.writeHtml(hUsage)
                                    end
                                 end
                              end
                           end

                        end
                     end
                  end

                  # resource - point of contact []
                  unless hResource[:pointOfContacts].empty? && hResource[:credits].empty?
                     @html.details do
                        @html.summary('Resource Contacts', {'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # contacts
                           hResource[:pointOfContacts].each do |hContact|
                              @html.details do
                                 @html.summary(hContact[:roleName], 'class' => 'h5')
                                 @html.section(:class => 'block') do
                                    responsibilityClass.writeHtml(hContact)
                                 end
                              end
                           end

                           # contacts
                           unless hResource[:credits].empty?
                              @html.details do
                                 @html.summary('Other Credits', 'class' => 'h5')
                                 @html.section(:class => 'block') do
                                    hResource[:credits].each do |credit|
                                       @html.em('Credit: ')
                                       @html.text!(credit)
                                       @html.br
                                    end
                                 end
                              end
                           end

                        end
                     end
                  end

                  # resource - temporal information
                  unless hResource[:timePeriod].empty? && hResource[:temporalResolutions].empty?
                     @html.details do
                        @html.summary('Temporal Information', {'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # time period
                           unless hResource[:timePeriod].empty?
                              temporalObj = {}
                              temporalObj[:timeInstant] = {}
                              temporalObj[:timePeriod] = hResource[:timePeriod]
                              temporalClass.writeHtml(temporalObj)
                           end

                           # temporal resolution []
                           unless hResource[:temporalResolutions].empty?
                              hResource[:temporalResolutions].each do |hResolution|
                                 @html.details do
                                    @html.summary('Resolution', 'class' => 'h5')
                                    @html.section(:class => 'block') do
                                       durationClass.writeHtml(hResolution)
                                    end
                                 end
                              end
                           end

                        end
                     end
                  end

                  # resource - spatial information
                  unless hResource[:spatialReferenceSystems].empty? &&
                     hResource[:spatialRepresentationTypes].empty?
                     hResource[:spatialRepresentations].empty?
                     hResource[:spatialResolutions].empty?
                     @html.details do
                        @html.summary('Spatial Information', {'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # representation type []
                           hResource[:spatialRepresentationTypes].each do |hRepType|
                              @html.em('Spatial Representation Type: ')
                              @html.text!(hRepType)
                              @html.br
                           end

                           # reference system []
                           hResource[:spatialReferenceSystems].each do |hRefSystem|
                              @html.details do
                                 @html.summary('Spatial Reference System', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    sRefClass.writeHtml(hRefSystem)
                                 end
                              end
                           end

                           # spatial representation []
                           hResource[:spatialRepresentations].each do |hRepresentation|
                              sRepClass.writeHtml(hRepresentation)
                           end

                           # spatial resolution []
                           hResource[:spatialResolutions].each do |hResolution|
                              resolutionClass.writeHtml(hResolution)
                           end

                        end
                     end
                  end

                  # resource - keywords [] {keyword}
                  unless hResource[:topicCategories].empty? &&
                     hResource[:keywords].empty?
                     @html.details do
                        @html.summary('Keywords', {'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # resource - topic categories []
                           hResource[:topicCategories].each do |category|
                              @html.em('Topic: ')
                              @html.text!(category)
                              @html.br
                           end

                           # resource - keywords []
                           hResource[:keywords].each do |hKeyword|
                              keywordClass.writeHtml(hKeyword)
                           end

                        end

                     end
                  end

                  # resource - taxonomy {taxonomy}
                  unless hResource[:taxonomy].empty?
                     @html.details do
                        @html.summary('Taxonomy', {'class' => 'h3'})
                        @html.section(:class => 'block') do
                           taxonomyClass.writeHtml(hResource[:taxonomy])
                        end
                     end
                  end


                  # TODO add extents []
                  # TODO add coverage description []
                  # TODO add graphic overview []
                  # TODO add formats []
                  # TODO add constraints []
                  # TODO add default locale {}
                  # TODO add other locale []
                  # TODO add maintenance
                  # TODO add environment
                  # TODO add supplemental information

               end # writeHtml
            end # Html_ResourceInfo

         end
      end
   end
end
