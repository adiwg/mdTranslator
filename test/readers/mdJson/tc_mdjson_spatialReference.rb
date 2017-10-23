# MdTranslator - minitest of
# reader / mdJson / module_spatialReference

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-12 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_spatialReference'

class TestReaderMdJsonSpatialReference < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::SpatialReferenceSystem
   aIn = TestReaderMdJsonParent.getJson('spatialReference.json')
   @@hIn = aIn['spatialReferenceSystem'][0]

   # TODO reinstate after schema update
   # def test_spatialReference_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'spatialReference.json')
   #     assert_empty errors
   #
   # end

   def test_complete_referenceSystem_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MD_ReferenceSystemTypeCode', metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      assert_equal 'identifier', metadata[:systemIdentifier][:identifier]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_empty_type

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['referenceSystemType'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      assert_equal 'identifier', metadata[:systemIdentifier][:identifier]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_missing_type

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('referenceSystemType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      assert_equal 'identifier', metadata[:systemIdentifier][:identifier]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_empty_system

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['referenceSystemIdentifier'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MD_ReferenceSystemTypeCode', metadata[:systemType]
      assert_empty metadata[:systemIdentifier]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_missing_system

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('referenceSystemIdentifier')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MD_ReferenceSystemTypeCode', metadata[:systemType]
      assert_empty metadata[:systemIdentifier]
      refute_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_empty_referenceSystemParameterSet

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['referenceSystemParameterSet'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MD_ReferenceSystemTypeCode', metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      assert_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_referenceSystem_missing_referenceSystemParameterSet

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('referenceSystemParameterSet')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'MD_ReferenceSystemTypeCode', metadata[:systemType]
      refute_empty metadata[:systemIdentifier]
      assert_empty metadata[:systemParameterSet]
      assert hResponse[:readerExecutionPass]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_referenceSystem_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
