# FGDC <<Class>> TransferInformation
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-31 original script

require 'adiwg/mdtranslator/internal/module_dateTimeFun'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class TransferInformation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hTransOpt)

                  hSpec = {}
                  unless hTransOpt[:distributionFormats].empty?
                     unless hTransOpt[:distributionFormats][0][:formatSpecification].empty?
                        hSpec = hTransOpt[:distributionFormats][0][:formatSpecification]
                     end
                  end

                  # transfer information 6.4.2.1.1 (formname) - format name (required)
                  # <- formatSpecification.identifier.identifier
                  # FGDC requires a format name for digital options (online and offline)
                  # the format name is saved in the identifier of the format specification
                  # of the first distribution format
                  # as backup, allow specification title to serve as format name
                  haveId = false
                  unless hSpec.empty?
                     if hSpec[:identifiers].empty?
                        @xml.tag!('formname', hSpec[:title])
                        haveId = true
                     else
                        unless hSpec[:identifiers][0][:identifier].nil?
                           @xml.tag!('formname', hSpec[:identifiers][0][:identifier])
                           haveId = true
                        end
                     end
                  end
                  unless haveId
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Distribution Format is missing format name'
                  end

                  # transfer information 6.4.2.1.2 (formvern) - format version number
                  # <- formatSpecification.edition
                  haveVersion = false
                  unless hSpec.empty?
                     unless hSpec[:edition].nil?
                        @xml.tag!('formvern', hSpec[:edition])
                        haveVersion = true
                     end
                  end
                  if !haveVersion && @hResponseObj[:writerShowTags]
                     @xml.tag!('formvern')
                  end

                  # transfer information 6.4.2.1.3 (formverd) - format version date
                  # <- formatSpecification.dates[].dateType='revision'
                  haveRevDate = false
                  unless hSpec.empty?
                     hSpec[:dates].each do |hDate|
                        if hDate[:dateType] == 'revision'
                           revDate = AdiwgDateTimeFun.stringDateFromDateTime(hDate[:date], hDate[:dateResolution])
                           revDate.gsub!(/[-]/,'')
                           unless revDate == 'ERROR'
                              @xml.tag!('formverd', revDate)
                              haveRevDate = true
                           end
                           break
                        end
                     end
                  end
                  if !haveRevDate && @hResponseObj[:writerShowTags]
                     @xml.tag!('formverd')
                  end

                  # transfer information 6.4.2.1.4 (formspec) - format specification
                  # <- formatSpecification.title
                  haveTitle = false
                  unless hSpec.empty?
                     unless hSpec[:title].nil?
                        @xml.tag!('formspec', hSpec[:title])
                        haveTitle = true
                     end
                  end
                  if !haveTitle && @hResponseObj[:writerShowTags]
                     @xml.tag!('formspec')
                  end

                  # transfer information 6.4.2.1.5 (formcont) - format information content
                  # <- formatSpecification.otherDetails[0]
                  haveContent = false
                  unless hSpec.empty?
                     unless hSpec[:otherDetails].empty?
                        @xml.tag!('formcont', hSpec[:otherDetails][0])
                        haveContent = true
                     end
                  end
                  if !haveContent && @hResponseObj[:writerShowTags]
                     @xml.tag!('formcont')
                  end

                  # transfer information 6.4.2.1.6 (filedec) - decompression method
                  # <- transferOption.distributionFormat[0].compressionMethod
                  haveCompress = false
                  unless hTransOpt[:distributionFormats].empty?
                     unless hTransOpt[:distributionFormats][0][:compressionMethod].nil?
                        @xml.tag!('filedec',hTransOpt[:distributionFormats][0][:compressionMethod])
                        haveCompress = true
                     end
                  end
                  if !haveCompress && @hResponseObj[:writerShowTags]
                     @xml.tag!('filedec')
                  end

                  # transfer information 6.4.2.1.7 (transize) - transfer size
                  # <- transferOption.transferSize
                  unless hTransOpt[:transferSize].nil?
                     @xml.tag!('transize', hTransOpt[:transferSize])
                  end
                  if hTransOpt[:transferSize].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('transize')
                  end

               end # writeXML
            end # DigitalFormat

         end
      end
   end
end
