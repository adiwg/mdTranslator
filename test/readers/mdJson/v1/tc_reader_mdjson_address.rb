# MdTranslator - minitest of
# reader / mdJson / module_address

# History:
# Stan Smith 2014-12-09 original script
# Stan Smith 2014-12-15 modified to use namespaces added to mdTranslator
# Stan Smith 2014-12-16 restructure tests to use schema examples
# Stan Smith 2014-12-19 added test for blank elements
# Stan Smith 2015-06-22 refactored setup to after removal of globals

# set reader version used by mdJson_reader.rb to require correct modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                @responseObj = {
                    readerVersionUsed: '1.2.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_address'

class TestReaderMdJsonAddress_v1_0 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Address
    @@responseObj = {}

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'address.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]

    def test_complete_address_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:deliveryPoints].length, 2
        assert_equal metadata[:deliveryPoints][0], 'deliveryPoint1'
        assert_equal metadata[:deliveryPoints][1], 'deliveryPoint2'
        assert_equal metadata[:city], 'city'
        assert_equal metadata[:adminArea], 'administrativeArea'
        assert_equal metadata[:postalCode], 'postalCode'
        assert_equal metadata[:country], 'country'
        assert_equal metadata[:eMailList].length, 2
        assert_equal metadata[:eMailList][0], 'example1@example.com'
        assert_equal metadata[:eMailList][1], 'example2@example.com'
    end

    def test_empty_address_elements
        hIn = @@hIn.clone
        hIn['deliveryPoint'] = []
        hIn['city'] = ''
        hIn['administrativeArea'] = ''
        hIn['postalCode'] = ''
        hIn['country'] = ''
        hIn['electronicMailAddress'] = []
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_empty metadata[:deliveryPoints]
        assert_nil metadata[:city]
        assert_nil metadata[:adminArea]
        assert_nil metadata[:postalCode]
        assert_nil metadata[:country]
        assert_empty metadata[:eMailList]
    end

    def test_missing_address_elements
        hIn = @@hIn.clone
        hIn['nothing'] = '0'
        hIn.delete('deliveryPoint')
        hIn.delete('city')
        hIn.delete('administrativeArea')
        hIn.delete('postalCode')
        hIn.delete('country')
        hIn.delete('electronicMailAddress')
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_empty metadata[:deliveryPoints]
        assert_nil metadata[:city]
        assert_nil metadata[:adminArea]
        assert_nil metadata[:postalCode]
        assert_nil metadata[:country]
        assert_empty metadata[:eMailList]
    end

    def test_empty_address_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end