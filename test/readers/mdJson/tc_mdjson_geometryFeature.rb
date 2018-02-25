# MdTranslator - minitest of
# reader / mdJson / module_geometryFeature

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geometryFeature'

class TestReaderMdJsonGeometryFeature < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeometryFeature
   aIn = TestReaderMdJsonParent.getJson('geometryFeature.json')
   @@hIn = aIn['geometryFeature'][0]

   def test_geometryFeature_schema

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)
      errors = JSON::Validator.fully_validate('geojson.json', @@hIn)
      assert_empty errors

   end

   def test_complete_geometryFeature

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'Feature', metadata[:type]
      assert_equal 'id', metadata[:id]
      refute_empty metadata[:bbox]
      refute_empty metadata[:geometryObject]
      refute_empty metadata[:properties]
      refute_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geometryFeature_empty_type

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['type'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson GeoJSON geometry feature type is missing'

   end

   def test_geometryFeature_missing_type

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('type')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson GeoJSON geometry feature type is missing'

   end

   def test_geometryFeature_empty_geometry

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['geometry'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'Feature', metadata[:type]
      assert_equal 'id', metadata[:id]
      refute_empty metadata[:bbox]
      assert_empty metadata[:geometryObject]
      refute_empty metadata[:properties]
      assert_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geometryFeature_missing_geometry

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('geometry')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson GeoJSON geometry feature geometry is missing'

   end

   def test_geometryFeature_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['id'] = ''
      hIn['bbox'] = []
      hIn['properties'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'Feature', metadata[:type]
      assert_nil metadata[:id]
      assert_empty metadata[:bbox]
      refute_empty metadata[:geometryObject]
      assert_empty metadata[:properties]
      refute_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geometryFeature_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('id')
      hIn.delete('bbox')
      hIn.delete('properties')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'Feature', metadata[:type]
      assert_nil metadata[:id]
      assert_empty metadata[:bbox]
      refute_empty metadata[:geometryObject]
      assert_empty metadata[:properties]
      refute_empty metadata[:computedBbox]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_geometryFeature

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson GeoJSON geometry feature object is empty'

   end

end
