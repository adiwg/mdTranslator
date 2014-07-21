# date, dateTime methods
# for ADIwg readers and writers

# History:
# 	Stan Smith 2013-09-26 original script
# 	Stan Smith 2013-12-06 added support for fractional seconds

require 'date'

module AdiwgDateTimeFun

	def self.dateTimeFromString(inDateTime)
		hFormats = {'YMDhmsLZ'=> '%Y-%m-%dT%H:%M:%S.%L%z',
					'YMDhmsL'=> '%Y-%m-%dT%H:%M:%S.%L',
					'YMDhmsZ'=> '%Y-%m-%dT%H:%M:%S%z',
					'YMDhms'=> '%Y-%m-%dT%H:%M:%S',
					'YMDhmZ'=> '%Y-%m-%dT%H:%M%z',
					'YMDhm'=> '%Y-%m-%dT%H:%M',
					'YMDhZ'=> '%Y-%m-%dT%H%z',
					'YMDh'=> '%Y-%m-%dT%H',
					'YMD'=> '%Y-%m-%d',
					'YM'=> '%Y-%m',
					'Y'=> '%Y'}
		hFormats.each do |dateResolution, format|
			myDateTime = DateTime.strptime(inDateTime,format) rescue false
			return myDateTime, dateResolution if myDateTime
		end

		return nil, 'ERROR'
	end

	def self.stringDateFromDateTime(myDateTime,dateResolution)
		s = case dateResolution
				when 'YMDhmsLZ','YMDhmsL','YMDhmsZ', 'YMDhms',
					'YMDhmZ', 'YMDhm', 'YMDhZ', 'YMDh','YMD'
					myDateTime.strftime('%Y-%m-%d')
				when 'YM'
					myDateTime.strftime('%Y-%m')
				when 'Y'
					myDateTime.strftime('%Y')
				else
					'ERROR'
			end

		return s
	end

	def self.stringDateTimeFromDateTime(myDateTime,dateResolution)
		s = case dateResolution
				when 'YMDhmsLZ'
					myDateTime.strftime('%Y-%m-%dT%H:%M:%S.%L%:z')
				when 'YMDhmsL'
					myDateTime.strftime('%Y-%m-%dT%H:%M:%S.%L')
				when 'YMDhmsZ'
					myDateTime.strftime('%Y-%m-%dT%H:%M:%S%:z')
				when 'YMDhms', 'YMD', 'YM', 'Y'
					myDateTime.strftime('%Y-%m-%dT%H:%M:%S')
				when 'YMDhmZ'
					myDateTime.strftime('%Y-%m-%dT%H:%M%:z')
				when 'YMDhm'
					myDateTime.strftime('%Y-%m-%dT%H:%M')
				when 'YMDhZ'
					myDateTime.strftime('%Y-%m-%dT%H%:z')
				when 'YMDh'
					myDateTime.strftime('%Y-%m-%dT%H')
				else
					'ERROR'
			end

		return s
	end

	def self.stringTimeFromDateTime(myDateTime,dateResolution)
		s = case dateResolution
				when 'YMDhmsLZ'
					myDateTime.strftime('%H:%M:%S.%L%:z')
				when 'YMDhmsL'
					myDateTime.strftime('%H:%M:%S.%L')
				when 'YMDhmsZ'
					myDateTime.strftime('%H:%M:%S%:z')
				when 'YMDhms'
					myDateTime.strftime('%H:%M:%S')
				when 'YMDhmZ'
					myDateTime.strftime('%H:%M%:z')
				when 'YMDhm'
					myDateTime.strftime('%H:%M')
				when 'YMDhZ'
					myDateTime.strftime('%H%:z')
				when 'YMDh'
					myDateTime.strftime('%H')
				else
					'ERROR'
			end

		return s
	end

end
