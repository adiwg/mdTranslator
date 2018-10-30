# MdTranslator - minitest of
# reader / mdJson / module_referenceSystemParameters

# History:
#  Stan Smith 2018-06-22 refactored to use mdJson construction helpers
#  Stan Smith 2017-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_referenceSystemParameters'

class TestReaderMdJsonReferenceSystemParameters < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ReferenceSystemParameters

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_parameterSet(true, true, true)

   @@mdHash = mdHash

   def test_referenceSystemParameterSet_schema

      # oneOf projection
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn.delete(:geodetic)
      hIn.delete(:verticalDatum)
      errors = TestReaderMdJsonParent.testSchema(hIn, 'referenceSystemParameterSet.json', :remove => %w(geodetic verticalDatum))
      assert_empty errors

      # oneOf geodetic
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn.delete(:projection)
      hIn.delete(:verticalDatum)
      errors = TestReaderMdJsonParent.testSchema(hIn, 'referenceSystemParameterSet.json', :remove => %w(projection verticalDatum))
      assert_empty errors

      # oneOf verticalDatum
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn.delete(:projection)
      hIn.delete(:geodetic)
      errors = TestReaderMdJsonParent.testSchema(hIn, 'referenceSystemParameterSet.json', :remove => %w(projection geodetic))
      assert_empty errors

   end

   def test_complete_referenceSystemParameterSet_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:projection]
      refute_empty metadata[:geodetic]
      refute_empty metadata[:verticalDatum]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_referenceSystemParameterSet_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['projection'] = {}
      hIn['geodetic'] = {}
      hIn['verticalDatum'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: reference system parameter set must have at least one projection, geodetic, or vertical datum: CONTEXT is testing'

   end

   def test_missing_referenceSystemParameterSet_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('projection')
      hIn.delete('geodetic')
      hIn.delete('verticalDatum')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: reference system parameter set must have at least one projection, geodetic, or vertical datum: CONTEXT is testing'

   end

   def test_empty_referenceSystemParameterSet_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: reference system parameter set is empty: CONTEXT is testing'

   end

end
