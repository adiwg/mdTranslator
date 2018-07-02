# MdTranslator - minitest of
# reader / mdJson / module_geometryProperties

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-25 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geometryProperties'

class TestReaderMdJsonGeometryProperties < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeometryProperties

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.properties
   mdHash[:identifier] << TDClass.build_identifier('geoJson properties identifier two')

   @@mdHash = mdHash

   def test_geometryProperties_schema

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)
      fragmentPath = '#/definitions/featureProperties'
      errors = JSON::Validator.fully_validate('geojson.json', @@mdHash, :fragment => fragmentPath)
      assert_empty errors

   end

   def test_complete_geometryProperties

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 2, metadata[:featureNames].length
      assert_equal 'feature name one', metadata[:featureNames][0]
      assert_equal 'feature name two', metadata[:featureNames][1]
      assert_equal 'description', metadata[:description]
      assert_equal 2, metadata[:identifiers].length
      assert_equal 'feature scope', metadata[:featureScope]
      assert_equal 'acquisition method', metadata[:acquisitionMethod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geometryProperties_empty

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['featureName'] = []
      hIn['description'] = ''
      hIn['identifier'] = []
      hIn['featureScope'] = ''
      hIn['acquisitionMethod'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_empty metadata[:featureNames]
      assert_nil metadata[:description]
      assert_empty metadata[:identifiers]
      assert_nil metadata[:featureScope]
      assert_nil metadata[:acquisitionMethod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geometryProperties_missing

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('featureName')
      hIn.delete('description')
      hIn.delete('identifier')
      hIn.delete('featureScope')
      hIn.delete('acquisitionMethod')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_empty metadata[:featureNames]
      assert_nil metadata[:description]
      assert_empty metadata[:identifiers]
      assert_nil metadata[:featureScope]
      assert_nil metadata[:acquisitionMethod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_geometryProperties

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: GeoJSON properties object is empty'

   end

end
