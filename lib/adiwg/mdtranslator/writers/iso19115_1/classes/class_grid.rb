# ISO <<Class>> GridRepresentation
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-16 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_dimension'
require_relative 'class_scope'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class Grid

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hGrid, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  dimensionClass = MD_Dimension.new(@xml, @hResponseObj)
                  scopeClass = MD_Scope.new(@xml, @hResponseObj)

                  # grid - scope
                  hGrid[:scope].each do |scope|
                     @xml.tag!('msr:scope') do
                        scopeClass.writeXML(scope, inContext)
                     end
                  end

                  # grid - number of dimensions (required)
                  unless hGrid[:numberOfDimensions].nil?
                     @xml.tag!('msr:numberOfDimensions') do
                        @xml.tag!('gco:Integer', hGrid[:numberOfDimensions].to_s)
                     end
                  end
                  if hGrid[:numberOfDimensions].nil?
                     @NameSpace.issueWarning(190, 'msr:numberOfDimensions', inContext)
                  end

                  # grid - axis dimension properties [] {MD_Dimension}
                  aDims = hGrid[:dimension]
                  aDims.each do |hDimension|
                     @xml.tag!('msr:axisDimensionProperties') do
                        dimensionClass.writeXML(hDimension, inContext)
                     end
                  end
                  if aDims.empty? && @hResponseObj[:writerShowTags]
                     @xml.tag!('msr:axisDimensionProperties')
                  end

                  # grid - cell geometry (required)
                  unless hGrid[:cellGeometry].nil?
                     @xml.tag!('msr:cellGeometry') do
                        codelistClass.writeXML('msr', 'iso_cellGeometry', hGrid[:cellGeometry])
                     end
                  end
                  if hGrid[:cellGeometry].nil?
                     @NameSpace.issueWarning(192, 'msr:cellGeometry', inContext)
                  end

                  # grid - transformation parameters availability (required)
                  @xml.tag!('msr:transformationParameterAvailability') do
                     @xml.tag!('gco:Boolean', hGrid[:transformationParameterAvailable])
                  end


               end # writeXML
            end # Grid class

         end
      end
   end
end
