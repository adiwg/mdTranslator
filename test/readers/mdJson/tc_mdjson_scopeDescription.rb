# MdTranslator - minitest of
# reader / mdJson / module_scopeDescription

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-14 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_scopeDescription'

class TestReaderMdJsonScopeDescription < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ScopeDescription
   aIn = TestReaderMdJsonParent.getJson('scopeDescription.json')
   @@hIn = aIn['scopeDescription'][0]

   def test_scopeDescription_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'scope.json', :fragment => 'scopeDescription')
      assert_empty errors

   end

   def test_complete_scopeDescription_dataset_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'dataset', metadata[:dataset]
      assert_equal 'attributes', metadata[:attributes]
      assert_equal 'features', metadata[:features]
      assert_equal 'other', metadata[:other]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_scopeDescription_empty_required

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['dataset'] = ''
      hIn['attributes'] = ''
      hIn['features'] = ''
      hIn['other'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson scope description needs at least one dataset, attribute, feature, or other'

   end

   def test_scopeDescription_missing_required

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['nonElement'] = ''
      hIn.delete('dataset')
      hIn.delete('attributes')
      hIn.delete('features')
      hIn.delete('other')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson scope description needs at least one dataset, attribute, feature, or other'

   end

   def test_empty_scopeDescription_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson scope description object is empty'

   end

end
