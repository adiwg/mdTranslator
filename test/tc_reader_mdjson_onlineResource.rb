# MdTranslator - minitest of
# reader / mdJson / module_onlineResource

# History:
# Stan Smith 2014-12-09 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_0.9.0/module_onlineResource'

class TestReaderMdJsonOnlineResource < MiniTest::Test

	def test_build_full_onlineResource_object

		json_string = '{ ' +
			'"uri": "http://thisIsAnExample.com", ' +
			'"protocol": "protocol", ' +
			'"name": "Name", ' +
			'"description": "Description", ' +
			'"function": "function"' +
		'}'
		hIn = JSON.parse(json_string)

		intObj = {
			olResURI: 'http://thisIsAnExample.com',
			olResProtocol: 'protocol',
			olResName: 'Name',
			olResDesc: 'Description',
			olResFunction: 'function'
		}

		assert_equal intObj, Md_OnlineResource.unpack(hIn)

	end

	def test_build_empty_onlineResource_object

		json_string = '{}'
		hIn = JSON.parse(json_string)
		intObj = nil

		assert_equal intObj, Md_OnlineResource.unpack(hIn)

	end

end
