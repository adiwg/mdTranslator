# HTML writer
# image information

# History:
#  Stan Smith 2017-04-02 refactored for mdTranslator 2.0
# 	Stan Smith 2015-08-21 original script

require_relative 'html_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_ImageInfo

               def initialize(html)
                  @html = html
               end

               def writeHtml(hImage)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)
                  
                  # image information - illumination elevation angle
                  unless hImage[:illuminationElevationAngle].nil?
                     @html.em('Illumination elevation angle: ')
                     @html.text!(hImage[:illuminationElevationAngle].to_s)
                     @html.br
                  end

                  # image information - illumination azimuth angle
                  unless hImage[:illuminationAzimuthAngle].nil?
                     @html.em('Illumination azimuth angle: ')
                     @html.text!(hImage[:illuminationAzimuthAngle].to_s)
                     @html.br
                  end

                  # image information - image condition
                  unless hImage[:imageCondition].nil?
                     @html.em('Image condition: ')
                     @html.text!(hImage[:imageCondition])
                     @html.br
                  end

                  # image information - cloud cover percentage
                  unless hImage[:cloudCoverPercent].nil?
                     @html.em('Cloud cover percentage: ')
                     @html.text!(hImage[:cloudCoverPercent].to_s)
                     @html.br
                  end

                  # image information - compression generation quantity
                  unless hImage[:compressionQuantity].nil?
                     @html.em('Compression generation quantity: ')
                     @html.text!(hImage[:compressionQuantity].to_s)
                     @html.br
                  end

                  # image information - image quality code {identifier}
                  unless hImage[:imageQualityCode].empty?
                     @html.div do
                        @html.div('Image Quality Code', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           identifierClass.writeHtml(hImage[:imageQualityCode])
                        end
                     end
                  end

                  # image information - triangulation information available {Boolean}
                  @html.em('Triangulation information available: ')
                  @html.text!(hImage[:triangulationIndicator].to_s)
                  @html.br

                  # image information - radiometric calibration information available {Boolean}
                  @html.em('Radiometric calibration available: ')
                  @html.text!(hImage[:radiometricCalibrationAvailable].to_s)
                  @html.br

                  # image information - camera calibration information available {Boolean}
                  @html.em('Camera calibration information available: ')
                  @html.text!(hImage[:cameraCalibrationAvailable].to_s)
                  @html.br

                  # image information - film distortion information available {Boolean}
                  @html.em('Film distortion information available: ')
                  @html.text!(hImage[:filmDistortionAvailable].to_s)
                  @html.br

                  # image information - lens distortion information available {Boolean}
                  @html.em('Lens distortion information available: ')
                  @html.text!(hImage[:lensDistortionAvailable].to_s)
                  @html.br

               end # writeHtml
            end # Html_ImageInfo

         end
      end
   end
end
