# ISO <<Class>> MD_GridSpatialRepresentation
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
# 	Stan Smith 2016-12-08 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_dimension'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class Grid

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hGrid, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  dimClass = MD_Dimension.new(@xml, @hResponseObj)


                  # grid - number of dimensions (required)
                  s = hGrid[:numberOfDimensions]
                  unless s.nil?
                     @xml.tag!('gmd:numberOfDimensions') do
                        @xml.tag!('gco:Integer', s.to_s)
                     end
                  end
                  if s.nil?
                     @NameSpace.issueWarning(190, 'gmd:numberOfDimensions', inContext)
                  end

                  # grid - axis dimension properties [{MD_Dimension}] (required)
                  aDims = hGrid[:dimension]
                  aDims.each do |hDimension|
                     @xml.tag!('gmd:axisDimensionProperties') do
                        dimClass.writeXML(hDimension, inContext)
                     end
                  end
                  if aDims.empty?
                     @NameSpace.issueWarning(191, 'gmd:axisDimensionProperties', inContext)
                  end

                  # grid - cell geometry (required)
                  s = hGrid[:cellGeometry]
                  unless s.nil?
                     @xml.tag!('gmd:cellGeometry') do
                        codelistClass.writeXML('gmd', 'iso_cellGeometry', s)
                     end
                  end
                  if s.nil?
                     @NameSpace.issueWarning(192, 'gmd:cellGeometry', inContext)
                  end

                  # grid - transformation parameters availability (required)
                  s = hGrid[:transformationParameterAvailable]
                  @xml.tag!('gmd:transformationParameterAvailability') do
                     @xml.tag!('gco:Boolean', s)
                  end

               end # writeXML
            end # Grid class

         end
      end
   end
end
