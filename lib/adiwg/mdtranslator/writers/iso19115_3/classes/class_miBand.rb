# ISO <<Class>> MD_Band attributes
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-04-08 original script.

require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MI_Band

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hAttribute)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  # miBand - band boundary definition {MI_BandDefinition}
                  s = hAttribute[:bandBoundaryDefinition]
                  unless s.nil?
                     @xml.tag!('mrc:bandBoundaryDefinition') do
                        codelistClass.writeXML('mrc', 'iso_bandDefinition', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:bandBoundaryDefinition')
                  end

                  # miBand - nominal spatial resolution {real}
                  s = hAttribute[:nominalSpatialResolution]
                  unless s.nil?
                     @xml.tag!('mrc:nominalSpatialResolution') do
                        @xml.tag!('gco:Real', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:nominalSpatialResolution')
                  end

                  # miBand - transfer function type code
                  # {MI_TransferFunctionTypeCode}
                  s = hAttribute[:transferFunctionType]
                  unless s.nil?
                     @xml.tag!('mrc:transferFunctionType') do
                        codelistClass.writeXML('mrc', 'iso_transferFunctionTypeCode', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:transferFunctionType')
                  end

                  # miBand - transmitted polarization orientation code
                  # {MI_PolarizationOrientationCode}
                  s = hAttribute[:transmittedPolarization]
                  unless s.nil?
                     @xml.tag!('mrc:transmittedPolarisation') do
                        codelistClass.writeXML('mrc', 'iso_polarisationOrientationCode', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:transmittedPolarisation')
                  end

                  # miBand - detected polarization orientation code
                  # {MI_PolarizationOrientationCode}
                  s = hAttribute[:detectedPolarization]
                  unless s.nil?
                     @xml.tag!('mrc:detectedPolarisation') do
                        codelistClass.writeXML('mrc', 'iso_polarisationOrientationCode', s)
                     end
                  end
                  if s.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('mrc:detectedPolarisation')
                  end

               end # writeXML
            end # MI_Band attributes

         end
      end
   end
end
