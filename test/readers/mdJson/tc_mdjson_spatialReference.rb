# MdTranslator - minitest of
# reader / mdJson / module_spatialReference

# History:
#  Stan Smith 2018-06-25 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-11-12 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_spatialReference'

class TestReaderMdJsonSpatialReference < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SpatialReferenceSystem

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_spatialReference_full

   @@mdHash = mdHash

   # TODO reinstate after schema update
   # def test_spatialReference_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'spatialReference.json')
   #     assert_empty errors
   #
   # end

   def test_complete_referenceSystem_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'spatial reference system type', metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      assert_equal 'identifier', metadata[:systemIdentifier][:identifier]
      assert_equal 'WKT', metadata[:systemWKT]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_empty_type

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['referenceSystemType'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      refute_nil metadata[:systemWKT]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_missing_type

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('referenceSystemType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      refute_nil metadata[:systemWKT]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_empty_identifier

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['referenceSystemIdentifier'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata[:systemType]
      assert_empty metadata[:systemIdentifier]
      refute_nil metadata[:systemWKT]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_missing_identifier

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('referenceSystemIdentifier')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata[:systemType]
      assert_empty metadata[:systemIdentifier]
      refute_nil metadata[:systemWKT]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_empty_parameterSet

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['referenceSystemParameterSet'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      refute_nil metadata[:systemWKT]
      assert_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_missing_parameterSet

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('referenceSystemParameterSet')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      refute_nil metadata[:systemWKT]
      assert_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_empty_wkt

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['referenceSystemWKT'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      assert_nil metadata[:systemWKT]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_missing_wkt

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('referenceSystemWKT')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      assert_nil metadata[:systemWKT]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_empty_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['referenceSystemType'] = ''
      hIn['referenceSystemIdentifier'] = {}
      hIn['referenceSystemWKT'] = ''
      hIn['referenceSystemParameterSet'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: spatial reference system must provide a reference system type, identifier, WKT, or parameter set: CONTEXT is testing'

   end

   def test_referenceSystem_missing_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('referenceSystemType')
      hIn.delete('referenceSystemIdentifier')
      hIn.delete('referenceSystemWKT')
      hIn.delete('referenceSystemParameterSet')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: spatial reference system must provide a reference system type, identifier, WKT, or parameter set: CONTEXT is testing'

   end

   def test_empty_referenceSystem_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: spatial reference system object is empty: CONTEXT is testing'

   end

end
