# unpack online resources
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-09-25 original script

require Rails.root + 'metadata/internal/internal_metadata_obj'

module AdiwgV1OnlineResource

	def self.unpack(resources)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		aResources = Array.new

		# step through each resource
		# ... and load each into an internal resource container
		resources.each do |resource|
			intOLRes = intMetadataClass.newOnlineResource

			# resource - web link
			if resource.has_key?('linkage')
				s = resource['linkage']
				if s != ''
					intOLRes[:olResLink] = s
				end
			end

			# resource - web link name
			if resource.has_key?('name')
				s = resource['name']
				if s != ''
					intOLRes[:olResName] = s
				end
			end

			# resource - web link description
			if resource.has_key?('description')
				s = resource['description']
				if s != ''
					intOLRes[:olResDesc] = s
				end
			end

			# resource - web link function
			if resource.has_key?('function')
				s = resource['function']
				if s != ''
					intOLRes[:olResFunction] = s
				end
			end

			aResources << intOLRes
		end

		return aResources
	end

end