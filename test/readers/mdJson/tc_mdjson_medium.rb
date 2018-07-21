# MdTranslator - minitest of
# reader / mdJson / module_medium

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-20 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_medium'

class TestReaderMdJsonMedium < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Medium

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.medium

   @@mdHash = mdHash

   def test_medium_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'medium.json')
      assert_empty errors

   end

   def test_complete_medium_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:mediumSpecification]
      assert_equal 99.9, metadata[:density]
      assert_equal 'density units', metadata[:units]
      assert_equal 9, metadata[:numberOfVolumes]
      assert_equal 2, metadata[:mediumFormat].length
      assert_equal 'medium format one', metadata[:mediumFormat][0]
      assert_equal 'medium format two', metadata[:mediumFormat][1]
      assert_equal 'medium note', metadata[:note]
      refute_empty metadata[:identifier]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_medium_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['mediumSpecification'] = {}
      hIn['density'] = ''
      hIn['units'] = ''
      hIn['numberOfVolumes'] = ''
      hIn['mediumFormat'] = []
      hIn['note'] = ''
      hIn['identifier'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:mediumSpecification]
      assert_nil metadata[:density]
      assert_nil metadata[:units]
      assert_nil metadata[:numberOfVolumes]
      assert_empty metadata[:mediumFormat]
      assert_nil metadata[:note]
      assert_empty metadata[:identifier]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_medium_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('mediumSpecification')
      hIn.delete('density')
      hIn.delete('units')
      hIn.delete('numberOfVolumes')
      hIn.delete('mediumFormat')
      hIn.delete('note')
      hIn.delete('identifier')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:mediumSpecification]
      assert_nil metadata[:density]
      assert_nil metadata[:units]
      assert_nil metadata[:numberOfVolumes]
      assert_empty metadata[:mediumFormat]
      assert_nil metadata[:note]
      assert_empty metadata[:identifier]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_medium_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: offline option (medium) is empty: CONTEXT is testing'

   end

end
