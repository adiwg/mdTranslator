require_relative 'html_scope'
require_relative 'html_plan'
require_relative 'html_requirement'
require_relative 'html_objective'
require_relative 'html_platform'
require_relative 'html_instrument'
require_relative 'html_operation'
require_relative 'html_event'
require_relative 'html_pass'
require_relative 'html_environment'

module ADIWG
  module Mdtranslator
    module Writers
      module Html
        class Html_Acquisition
          def initialize(html)
            @html = html
          end

          def writeHtml(hAcquisition)
              scopeClass = Html_Scope.new(@html)
              planClass = Html_Plan.new(@html)
              requirementClass = Html_Requirement.new(@html)
              objectiveClass = Html_Objective.new(@html)
              platformClass = Html_Platform.new(@html)
              instrumentClass = Html_Instrument.new(@html)
              operationClass = Html_Operation.new(@html)
              eventClass = Html_Event.new(@html)
              passClass = Html_Pass.new(@html)
              environmentClass = Html_Environment.new(@html)

            # scope
            unless hAcquisition[:scope].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Scope', {'class' => 'h4'})
                  @html.section(:class => 'block') do
                    scopeClass.writeHtml(hAcquisition[:scope])
                  end
                end
              end
            end

            # plan
            unless hAcquisition[:plan].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Plans', {'class' => 'h4'})
                  hAcquisition[:plan].each do |plan|
                    @html.section(:class => 'block') do
                      @html.details do
                        @html.summary('Plan', {'class' => 'h5'})
                        planClass.writeHtml(plan)
                      end
                    end
                  end
                end
              end
            end

            # requirement
            unless hAcquisition[:requirement].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Requirements', {'class' => 'h4'})
                  hAcquisition[:requirement].each do |requirement|
                    @html.section(:class => 'block') do
                      @html.details do
                        @html.summary('Requirement', {'class' => 'h5'})
                        requirementClass.writeHtml(requirement)
                      end
                    end
                  end
                end
              end
            end

            # objective
            unless hAcquisition[:objective].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Objectives', {'class' => 'h4'})
                  hAcquisition[:objective].each do |objective|
                    @html.section(:class => 'block') do
                      @html.details do
                        @html.summary('Objective', {'class' => 'h5'})
                        objectiveClass.writeHtml(objective)
                      end
                    end
                  end
                end
              end
            end

            # platform
            unless hAcquisition[:objective].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Objectives', {'class' => 'h4'})
                  hAcquisition[:objective].each do |objective|
                    @html.section(:class => 'block') do
                      @html.details do
                        @html.summary('Objective', {'class' => 'h5'})
                        planClass.writeHtml(objective)
                      end
                    end
                  end
                end
              end
            end

            # platform
            unless hAcquisition[:platform].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Platforms', {'class' => 'h4'})
                  hAcquisition[:platform].each do |platform|
                    @html.section(:class => 'block') do
                      @html.details do
                        @html.summary('Platform', {'class' => 'h5'})
                        platformClass.writeHtml(platform)
                      end
                    end
                  end
                end
              end
            end

            # Instrument
            unless hAcquisition[:instrument].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Instruments', {'class' => 'h4'})
                  hAcquisition[:instrument].each do |instrument|
                    @html.section(:class => 'block') do
                      @html.details do
                        @html.summary('Instrument', {'class' => 'h5'})
                        instrumentClass.writeHtml(instrument)
                      end
                    end
                  end
                end
              end
            end

            # operation
            unless hAcquisition[:operation].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Operations', {'class' => 'h4'})
                  hAcquisition[:operation].each do |operation|
                    @html.section(:class => 'block') do
                      @html.details do
                        @html.summary('Operation', {'class' => 'h5'})
                        operationClass.writeHtml(operation)
                      end
                    end
                  end
                end
              end
            end

            # Event
            unless hAcquisition[:event].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Events', {'class' => 'h4'})
                  hAcquisition[:event].each do |event|
                    @html.section(:class => 'block') do
                      @html.details do
                        @html.summary('Event', {'class' => 'h5'})
                        eventClass.writeHtml(event)
                      end
                    end
                  end
                end
              end
            end

            # Pass
            unless hAcquisition[:pass].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Passes', {'class' => 'h4'})
                  hAcquisition[:pass].each do |pass|
                    @html.section(:class => 'block') do
                      @html.details do
                        @html.summary('Pass', {'class' => 'h5'})
                        passClass.writeHtml(pass)
                      end
                    end
                  end
                end
              end
            end

            # Environment
            unless hAcquisition[:environment].empty?
              @html.section(:class => 'block') do
                @html.details do
                  @html.summary('Environment', {'class' => 'h4'})
                  @html.section(:class => 'block') do
                    environmentClass.writeHtml(hAcquisition[:environment])
                  end
                end
              end
            end

          end
        end
      end
    end
  end
end
