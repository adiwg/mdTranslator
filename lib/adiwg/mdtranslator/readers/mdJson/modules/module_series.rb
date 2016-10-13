# unpack series
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-12 original script

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Series

                    def self.unpack(hSeries, responseObj)

                        # return nil object if input is empty
                        if hSeries.empty?
                            responseObj[:readerExecutionMessages] << 'Series object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intSeries = intMetadataClass.newSeries

                        # series - seriesName
                        if hSeries.has_key?('seriesName')
                            if hSeries['seriesName'] != ''
                                intSeries[:seriesName] = hSeries['seriesName']
                            end
                        end

                        # series - series issue
                        if hSeries.has_key?('seriesIssue')
                            if hSeries['seriesIssue'] != ''
                                intSeries[:seriesIssue] = hSeries['seriesIssue']
                            end
                        end

                        # series - issue page
                        if hSeries.has_key?('issuePage')
                            if hSeries['issuePage'] != ''
                                intSeries[:issuePage] = hSeries['issuePage']
                            end
                        end

                        return intSeries

                    end

                end

            end
        end
    end
end
