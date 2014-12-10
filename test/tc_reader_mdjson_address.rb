# MdTranslator - minitest of
# reader / mdJson / module_address

# History:
# Stan Smith 2014-12-09 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_0.9.0/module_address'

class TestReaderMdjsonAddress < MiniTest::Test

	def test_build_full_address_object

		json_string = '{ ' +
			'"deliveryPoint": ["99 Aa","Aa 99"],' +
			'"city": "Aa",' +
			'"administrativeArea": "AA",' +
			'"postalCode": "99999-9999",' +
			'"country": "AA",' +
			'"electronicMailAddress": ["hello@example.com","bye@example.com"]' +
		'}'
		hIn = JSON.parse(json_string)

		intObj = {
			deliveryPoints: ['99 Aa', 'Aa 99'],
			city: 'Aa',
			adminArea: 'AA',
			postalCode: '99999-9999',
			country: 'AA',
			eMailList: %w[hello@example.com bye@example.com]
		}

		@return = Md_Address.unpack(hIn)

		assert_equal intObj, @return

	end

	def test_build_empty_address_object

		json_string = '{}'
		hIn = JSON.parse(json_string)
		intObj = nil

		@return = Md_Address.unpack(hIn)

		assert_equal intObj, @return

	end


end