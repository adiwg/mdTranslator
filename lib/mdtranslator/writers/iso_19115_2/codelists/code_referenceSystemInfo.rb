# ISO <<CodeLists>> gmd:referenceSystemInfo

# History:
# 	Stan Smith 2013-11-25 original script

class ReferenceSystemInfo
	def initialize(xml)
		@xml = xml
	end

	def writeXML(codeName)
		case(codeName)
			when 'NAD27'
				title = 'North American Datum 1927 EPSG::4267'
				href = 'https://www.ngdc.noaa.gov/docucomp/32c8e7d0-95ed-11e0-aa80-0800200c9a66'
			when 'NAD83'
				title = 'North American Datum 1983 EPSG::4269'
				href = 'https://www.ngdc.noaa.gov/docucomp/65f8b220-95ed-11e0-aa80-0800200c9a66'
			when 'Clarke1866'
				title = 'Clarke 1866 EPSG::7008'
				href = 'https://www.ngdc.noaa.gov/docucomp/a75c0b90-95ed-11e0-aa80-0800200c9a66'
			when 'GRS80'
				title = 'Geodetic Reference System 1980 EPSG::7019'
				href = 'https://www.ngdc.noaa.gov/docucomp/c3895520-95ed-11e0-aa80-0800200c9a66'
			when 'WGS84'
				title = 'World Geodetic System 1984 EPSG::4326'
				href = 'https://www.ngdc.noaa.gov/docucomp/2504d000-8345-11e1-b0c4-0800200c9a66'
			when 'NAVD88'
				title = 'North American Vertical Datum 1988 EPSG::5103'
				href = 'https://www.ngdc.noaa.gov/docucomp/7bfef30a-970e-48de-a173-675dc4b61695'
			when 'MLW'
				title = 'Mean Low Water depth EPSG::5867'
				href = 'https://www.ngdc.noaa.gov/docucomp/3c7f7694-46d6-41cb-9bca-0fee2928aeef'
			when 'MLLW'
				title = 'Mean Lower Low Water depth EPSG::5866'
				href = 'https://www.ngdc.noaa.gov/docucomp/defe1bdc-40fd-426b-a262-a57b9909d08c'
			when 'MHW'
				title = 'Mean High Water height EPSG::5868'
				href = 'https://www.ngdc.noaa.gov/docucomp/0916ce75-a087-46f8-933f-200353c9ffb8'
			when 'MHHW'
				title = 'Mean Higher High Water height EPSG::5869'
				href = 'https://www.ngdc.noaa.gov/docucomp/9e461b22-6ab2-4393-9567-ad18991cc232'
		else
			title = 'OTHER REFERENCE SYSTEM'
			href = ''
		end

		# write xml
		attributes = {}
		attributes['xlink:title'] = title
		attributes['xlink:href'] = href
		@xml.tag!('gmd:referenceSystemInfo',attributes)
	end

end





