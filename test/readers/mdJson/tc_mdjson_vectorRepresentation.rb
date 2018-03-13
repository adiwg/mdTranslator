# MdTranslator - minitest of
# reader / mdJson / module_vectorRepresentation

# History:
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_vectorRepresentation'

class TestReaderMdJsonVectorRepresentation < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::VectorRepresentation
   aIn = TestReaderMdJsonParent.getJson('vector.json')
   @@hIn = aIn['vectorRepresentation'][0]

   def test_vectorRepresentation_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'vectorRepresentation.json')
      assert_empty errors

   end

   def test_complete_vectorRepresentation_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'topologyLevel', metadata[:topologyLevel]
      assert_equal 2, metadata[:vectorObject].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_vectorRepresentation_empty_required

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['topologyLevel'] = ''
      hIn['vectorObject'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: vector representation must have a topology level or vector object'

   end

   def test_vectorRepresentation_missing_required

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['nonElement'] = ''
      hIn.delete('topologyLevel')
      hIn.delete('vectorObject')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: vector representation must have a topology level or vector object'

   end

   def test_empty_vectorRepresentation_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: mdJson reader: vector representation object is empty'

   end

end
