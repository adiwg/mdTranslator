module ADIWG
    module Mdtranslator
        module Writers
            module Html
                class Html_Platform
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hPlatform)
                        # platformId
                        unless hPlatform[:platformId].empty?
                            @html.em('Platform ID', {'class' => 'h4'})
                            @html.section(:class => 'block') do
                                @html.text!(hPlatform[:platformId])
                            end
                        end

                        # citation
                        unless hPlatform[:citation].empty?
                            @html.em('Citation: ')
                            @html.section(:class => 'block') do
                                citationClass.writeHtml(hPlatform[:citation])
                            end
                        end

                        # identifier
                        unless hPlatform[:identifier].empty?
                            @html.em('Identifier: ')
                            @html.section(:class => 'block') do
                                identifierClass.writeHtml(hPlatform[:identifier])
                            end
                        end

                        # description
                        unless hPlatform[:description].empty?
                            @html.em('Description: ')
                            @html.section(:class => 'block') do
                                @html.text!(hPlatform[:description])
                            end
                        end

                        # sponsor
                        unless hEvent[:sponsors].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Sponsors', {'class' => 'h4'})
                                    hEvent[:sponsors].each do |responsibility|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Responsibility', {'class' => 'h5'})
                                                responsibilityClass.writeHtml(responsibility)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        # instrument
                        unless hEvent[:instruments].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('Instruments', {'class' => 'h4'})
                                    hEvent[:instruments].each do |instrument|
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

                        # history
                        unless hEvent[:history].empty?
                            @html.section(:class => 'block') do
                                @html.details do
                                    @html.summary('History', {'class' => 'h4'})
                                    hEvent[:history].each do |instrumentationEventList|
                                        @html.section(:class => 'block') do
                                        @html.details do
                                            @html.summary('Instrumentation Event List', {'class' => 'h5'})
                                                instrumentationEventListClass.writeHtml(instrumentationEventList)
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
    end
end