# HTML writer
# resource information

# History:
#  Stan Smith 2018-10-17 refactor for mdJson schema 2.6.0
#  Stan Smith 2018-04-06 changed taxonomy to an array
#  Stan Smith 2017-05-19 removed iso topicCategory (now presented as keywords)
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
require_relative 'html_spatialResolution'
require_relative 'html_keyword'
require_relative 'html_taxonomy'
require_relative 'html_graphic'
require_relative 'html_constraint'
require_relative 'html_coverageInfo'
require_relative 'html_locale'
require_relative 'html_format'
require_relative 'html_maintenance'
require_relative 'html_extent'

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
                  referenceClass = Html_SpatialReference.new(@html)
                  representationClass = Html_SpatialRepresentation.new(@html)
                  resolutionClass = Html_SpatialResolution.new(@html)
                  keywordClass = Html_Keyword.new(@html)
                  taxonomyClass = Html_Taxonomy.new(@html)
                  graphicClass = Html_Graphic.new(@html)
                  constraintClass = Html_Constraint.new(@html)
                  coverageClass = Html_CoverageInfo.new(@html)
                  localeClass = Html_Locale.new(@html)
                  formatClass = Html_Format.new(@html)
                  maintenanceClass = Html_Maintenance.new(@html)
                  extentClass = Html_Extent.new(@html)

                  # resource - type [] {resourceType}
                  hResource[:resourceTypes].each do |hType|
                     typeClass.writeHtml(hType)
                  end

                  # resource - status [] {statusCode}
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
                              @html.section(:class => 'block') do
                                 @html.text!(hResource[:shortAbstract])
                              end
                              @html.br
                           end

                           # full abstract
                           unless hResource[:abstract].nil?
                              @html.em('Full Abstract:')
                              @html.section(:class => 'block') do
                                 @html.text!(hResource[:abstract])
                              end
                              @html.br

                           end

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
                              @html.section(:class => 'block') do
                                 @html.text!(hResource[:purpose])
                              end
                              @html.br
                           end

                           # usage and limitation
                           unless hResource[:resourceUsages].empty?
                              counter = 0
                              hResource[:resourceUsages].each do |hUsage|
                                 counter += 1
                                 @html.details do
                                    @html.summary('Usage and Limitation '+counter.to_s, {'class' => 'h5'})
                                    @html.section(:class => 'block') do
                                       usageClass.writeHtml(hUsage)
                                    end
                                 end
                              end
                           end

                        end
                     end
                  end

                  # resource - graphic overview [] {graphicOverview}
                  unless hResource[:graphicOverviews].empty?
                     @html.details do
                        @html.summary('Graphic Overviews', {'id' => 'resourceInfo-overview', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           counter = 0
                           hResource[:graphicOverviews].each do |hGraphic|
                              counter += 1
                              @html.details do
                                 @html.summary('Overview '+counter.to_s, 'class' => 'h5')
                                 @html.section(:class => 'block') do
                                    graphicClass.writeHtml(hGraphic)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # resource - point of contact [] {responsibility}
                  unless hResource[:pointOfContacts].empty? && hResource[:credits].empty?
                     @html.details do
                        @html.summary('Resource Contacts', {'id' => 'resourceInfo-contacts', 'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # contacts - responsibility
                           hResource[:pointOfContacts].each do |hContact|
                              @html.details do
                                 @html.summary(hContact[:roleName], 'class' => 'h5')
                                 @html.section(:class => 'block') do
                                    responsibilityClass.writeHtml(hContact)
                                 end
                              end
                           end

                           # contacts - credits
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
                        @html.summary('Temporal Information', {'id' => 'resourceInfo-temporal', 'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # time period {timePeriod}
                           unless hResource[:timePeriod].empty?
                              temporalObj = {}
                              temporalObj[:timeInstant] = {}
                              temporalObj[:timePeriod] = hResource[:timePeriod]
                              temporalClass.writeHtml(temporalObj)
                           end

                           # temporal resolution [] {resolution}
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
                        @html.summary('Spatial Information', {'id' => 'resourceInfo-spatial', 'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # representation type [] {spatialRepresentation}
                           hResource[:spatialRepresentationTypes].each do |hRepType|
                              @html.em('Spatial Representation Type: ')
                              @html.text!(hRepType)
                              @html.br
                           end

                           # spatial resolution [] {resolution}
                           unless hResource[:spatialResolutions].empty?
                              @html.details do
                                 @html.summary('Spatial Resolutions', {'class' => 'h5'})
                                 @html.section(:class => 'block') do

                                    # keep like resolution types together
                                    # find all scale factors
                                    hResource[:spatialResolutions].each do |hResolution|
                                       unless hResolution[:scaleFactor].nil?
                                          resolutionClass.writeHtml(hResolution)
                                       end
                                    end

                                    # find all measures
                                    hResource[:spatialResolutions].each do |hResolution|
                                       unless hResolution[:measure].empty?
                                          resolutionClass.writeHtml(hResolution)
                                       end
                                    end

                                    # find all coordinate resolutions
                                    hResource[:spatialResolutions].each do |hResolution|
                                       unless hResolution[:coordinateResolution].empty?
                                          resolutionClass.writeHtml(hResolution)
                                       end
                                    end

                                    # find all bearing distance resolutions
                                    hResource[:spatialResolutions].each do |hResolution|
                                       unless hResolution[:bearingDistanceResolution].empty?
                                          resolutionClass.writeHtml(hResolution)
                                       end
                                    end

                                    # find all geographic resolutions
                                    hResource[:spatialResolutions].each do |hResolution|
                                       unless hResolution[:geographicResolution].empty?
                                          resolutionClass.writeHtml(hResolution)
                                       end
                                    end

                                 end
                              end
                           end

                           # reference system [] {spatialReference}
                           hResource[:spatialReferenceSystems].each do |hRefSystem|
                              @html.details do
                                 @html.summary('Spatial Reference System', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    referenceClass.writeHtml(hRefSystem)
                                 end
                              end
                           end

                           # spatial representation [] {spatialRepresentation}
                           hResource[:spatialRepresentations].each do |hRepresentation|
                              representationClass.writeHtml(hRepresentation)
                           end

                        end
                     end
                  end

                  # resource - extent [] {extent}
                  unless hResource[:extents].empty?
                     @html.details do
                        @html.summary('Spatial, Temporal, and Vertical Extents', {'id' => 'resourceInfo-extent', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           hResource[:extents].each do |hExtent|
                              @html.details do
                                 @html.summary('Extent', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    extentClass.writeHtml(hExtent)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # resource - keywords [] {keyword}
                  unless hResource[:keywords].empty?
                     @html.details do
                        @html.summary('Keywords', {'id' => 'resourceInfo-keyword', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           hResource[:keywords].each do |hKeyword|
                              keywordClass.writeHtml(hKeyword)
                           end
                        end
                     end
                  end

                  # resource - taxonomy {taxonomy}
                  unless hResource[:taxonomy].empty?
                     @html.details do
                        @html.summary('Taxonomy', {'id' => 'resourceInfo-taxonomy', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           counter = 0
                           hResource[:taxonomy].each do |hTaxonomy|
                              counter += 1
                              @html.details do
                                 @html.summary('Taxonomic Structure '+counter.to_s, 'class' => 'h5')
                                 @html.section(:class => 'block') do
                                    taxonomyClass.writeHtml(hTaxonomy)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # resource - constraints [] {constraint}
                  unless hResource[:constraints].empty?
                     @html.details do
                        @html.summary('Constraints', {'id' => 'resourceInfo-constraint', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           hResource[:constraints].each do |hConstraint|
                              @html.details do
                                 @html.summary(hConstraint[:type].capitalize+' Constraint', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    constraintClass.writeHtml(hConstraint)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # resource - coverage description [] {coverageInfo}
                  unless hResource[:coverageDescriptions].empty?
                     @html.details do
                        @html.summary('Coverage Description', {'id' => 'resourceInfo-Coverage', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           hResource[:coverageDescriptions].each do |hCoverage|
                              @html.details do
                                 @html.summary(hCoverage[:coverageName], {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    coverageClass.writeHtml(hCoverage)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # resource - locale
                  unless hResource[:defaultResourceLocale].empty? && hResource[:otherResourceLocales].empty?
                     @html.details do
                        @html.summary('Resource Locales', {'id' => 'resourceInfo-locale', 'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # default resource locales {locale}
                           unless hResource[:defaultResourceLocale].empty?
                              @html.details do
                                 @html.summary('Default Locale', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    localeClass.writeHtml(hResource[:defaultResourceLocale])
                                 end
                              end
                           end

                           # other resource locales [] {locale}
                           hResource[:otherResourceLocales].each do |hLocale|
                              @html.details do
                                 @html.summary('Other Locale', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    localeClass.writeHtml(hLocale)
                                 end
                              end
                           end

                        end
                     end
                  end

                  # resource - formats [] {format}
                  unless hResource[:resourceFormats].empty?
                     @html.details do
                        @html.summary('Resource Formats', {'id' => 'resourceInfo-format', 'class' => 'h3'})
                        @html.section(:class => 'block') do
                           hResource[:resourceFormats].each do |hFormat|
                              @html.details do
                                 @html.summary('Format', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    formatClass.writeHtml(hFormat)
                                 end
                              end
                           end
                        end
                     end
                  end

                  # resource - supplemental information
                  unless hResource[:resourceMaintenance].empty? &&
                     hResource[:environmentDescription].nil? &&
                     hResource[:supplementalInfo].nil?
                     @html.details do
                        @html.summary('Supplemental Information', {'id' => 'resourceInfo-supplemental', 'class' => 'h3'})
                        @html.section(:class => 'block') do

                           # supplemental - maintenance [] {maintenance}
                           hResource[:resourceMaintenance].each do |hMaint|
                              @html.details do
                                 @html.summary('Resource Maintenance', {'class' => 'h5'})
                                 @html.section(:class => 'block') do
                                    maintenanceClass.writeHtml(hMaint)
                                 end
                              end
                           end

                           # supplemental - environment description
                           unless hResource[:environmentDescription].nil?
                              @html.em('Environment Description:')
                              @html.section(:class => 'block') do
                                 @html.text!(hResource[:environmentDescription])
                              end
                           end

                           # supplemental - supplemental information
                           unless hResource[:supplementalInfo].nil?
                              @html.em('Supplemental Information:')
                              @html.section(:class => 'block') do
                                 @html.text!(hResource[:supplementalInfo])
                              end
                           end

                        end
                     end
                  end

               end # writeHtml
            end # Html_ResourceInfo

         end
      end
   end
end
