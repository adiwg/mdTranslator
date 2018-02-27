# MdTranslator - minitest of
# reader / mdJson / module_geometryCollection

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-11 added computedBbox computation
#   Stan Smith 2016-10-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geometryCollection'

class TestReaderMdJsonGeometryCollection < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeometryCollection
   aIn = TestReaderMdJsonParent.getJson('geometryCollection.json')
   @@hIn = aIn['geometryCollection'][0]

   def test_geometryCollection_schema

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)
      errors = JSON::Validator.fully_validate('geojson.json', @@hIn)
      assert_empty errors

   end

   def test_complete_geometryCollection

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'GeometryCollection', metadata[:type]
      refute_empty metadata[:bbox]
      refute_empty metadata[:geometryObjects]
      refute_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geometryCollection_empty_type

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['type'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson GeoJSON geometry collection type is missing'

   end

   def test_geometryCollection_missing_type

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('type')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson GeoJSON geometry collection type is missing'

   end

   def test_geometryCollection_empty_geometries

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['geometries'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'GeometryCollection', metadata[:type]
      refute_empty metadata[:bbox]
      assert_empty metadata[:geometryObjects]
      assert_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geometryCollection_missing_geometries

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('geometries')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson GeoJSON geometry collection geometries are missing'

   end

   def test_geometryCollection_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['bbox'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'GeometryCollection', metadata[:type]
      assert_empty metadata[:bbox]
      refute_empty metadata[:geometryObjects]
      refute_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geometryCollection_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('bbox')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'GeometryCollection', metadata[:type]
      assert_empty metadata[:bbox]
      refute_empty metadata[:geometryObjects]
      refute_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_geometryCollection

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: GeoJSON geometry collection object is empty'

   end

end
