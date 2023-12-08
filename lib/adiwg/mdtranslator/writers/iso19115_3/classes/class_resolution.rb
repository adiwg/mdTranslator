# ISO <<Class>> MD_Resolution
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-03-21 original script

require_relative 'class_measure'
require_relative 'class_fraction'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_Resolution

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hResolution, inContext = nil)

                  # classes used
                  measureClass = Measure.new(@xml, @hResponseObj)
                  fractionClass = MD_RepresentativeFraction.new(@xml, @hResponseObj)

                  outContext = 'resolution'
                  outContext = inContext + ' resolution' unless inContext.nil?

                  # spatial resolution - equivalent scale
                  unless hResolution[:scaleFactor].nil?
                     @xml.tag!('mri:MD_Resolution') do
                        @xml.tag!('mri:equivalentScale') do
                           fractionClass.writeXML(hResolution[:scaleFactor], outContext)
                        end
                     end
                  end

                  # spatial resolution - distance (when type='distance')
                  unless hResolution[:measure].empty?
                     hMeasure = hResolution[:measure]
                     unless hMeasure.empty?
                        if hMeasure[:type] == 'distance'
                           @xml.tag!('mri:MD_Resolution') do
                              @xml.tag!('mri:distance') do
                                 measureClass.writeXML(hMeasure)
                              end
                           end
                        end
                     end
                  end

                  # spatial resolution - angular distance (when type='angle')
                  unless hResolution[:measure].empty?
                     hMeasure = hResolution[:measure]
                     unless hMeasure.empty?
                        if hMeasure[:type] == 'angle'
                           @xml.tag!('mri:MD_Resolution') do
                              @xml.tag!('mri:angularDistance') do
                                 measureClass.writeXML(hMeasure)
                              end
                           end
                        end
                     end
                  end

                  # spatial resolution - distance (when type='vertical')
                  unless hResolution[:measure].empty?
                     hMeasure = hResolution[:measure]
                     unless hMeasure.empty?
                        if hMeasure[:type] == 'vertical'
                           @xml.tag!('mri:MD_Resolution') do
                              @xml.tag!('mri:vertical') do
                                 measureClass.writeXML(hMeasure)
                              end
                           end
                        end
                     end
                  end

                  # spatial resolution - level of detail (when type='levelOfDetail')
                  unless hResolution[:levelOfDetail].nil?
                     @xml.tag!('mri:MD_Resolution') do
                        @xml.tag!('mri:levelOfDetail') do
                           @xml.tag!('gco:CharacterString', hResolution[:levelOfDetail])
                        end
                     end
                  end

               end # writeXML
            end # Measure class

         end
      end
   end
end
