# ISO <<Class>> CI_Date
# writer output in XML

# History:
# 	Stan Smith 2013-08-26 original script
# 	Stan Smith 2013-11-21 support for date or datetime

require 'builder'
require Rails.root + 'metadataxx/internal/module_dateTimeFun'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/codelists/code_dateType'

class CI_Date

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hDate)

		# classes used
		dateTypeCode = CI_DateTypeCode.new(@xml)

		citDateTime = hDate[:dateTime]
		citDateRes = hDate[:dateResolution]
		citDateType = hDate[:dateType]

		@xml.tag!('gmd:CI_Date') do

			# date - date - required
			if citDateTime.nil?
				@xml.tag!('gmd:date',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:date') do

					if citDateRes.length > 3
						# if time, requires all time fields
						dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(citDateTime,'YMDhmsZ')
						@xml.tag!('gco:DateTime',dateStr)
					else
						dateStr = AdiwgDateTimeFun.stringDateFromDateTime(citDateTime,citDateRes)
						@xml.tag!('gco:Date',dateStr)
					end

				end

			end

			# date - date type - required
			if citDateType.nil?
				@xml.tag!('gmd:dateType',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:dateType') do
					dateTypeCode.writeXML(citDateType)
				end
			end
		end

	end

end
