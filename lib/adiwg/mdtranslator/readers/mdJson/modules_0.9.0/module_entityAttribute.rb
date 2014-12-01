# unpack an data entity attribute
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-12-01 original script

module Md_EntityAttribute

	def self.unpack(hAttribute)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intAttribute = intMetadataClass.newEntityAttribute

		# attribute - common name
		if hAttribute.has_key?('commonName')
			s = hAttribute['commonName']
			if s != ''
				intAttribute[:attributeName] = s
			end
		end

		# attribute - code name
		if hAttribute.has_key?('codeName')
			s = hAttribute['codeName']
			if s != ''
				intAttribute[:attributeCode] = s
			end
		end

		# attribute - definition
		if hAttribute.has_key?('definition')
			s = hAttribute['definition']
			if s != ''
				intAttribute[:attributeDefinition] = s
			end
		end

		# attribute - data type
		if hAttribute.has_key?('dataType')
			s = hAttribute['dataType']
			if s != ''
				intAttribute[:dataType] = s
			end
		end

		# attribute - required attribute?
		if hAttribute.has_key?('required')
			s = hAttribute['required']
			if s != ''
				intAttribute[:required] = s
			end
		end

		# attribute - units of measure
		if hAttribute.has_key?('units')
			s = hAttribute['units']
			if s != ''
				intAttribute[:unitOfMeasure] = s
			end
		end

		# attribute - domain ID
		if hAttribute.has_key?('domainId')
			s = hAttribute['domainId']
			if s != ''
				intAttribute[:domainId] = s
			end
		end

		# attribute - minimum value
		if hAttribute.has_key?('minValue')
			s = hAttribute['minValue']
			if s != ''
				intAttribute[:minValue] = s
			end
		end

		# attribute - maximum value
		if hAttribute.has_key?('maxValue')
			s = hAttribute['maxValue']
			if s != ''
				intAttribute[:maxValue] = s
			end
		end

		return intAttribute

	end

end
