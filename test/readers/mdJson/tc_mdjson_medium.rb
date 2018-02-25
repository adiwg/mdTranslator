# MdTranslator - minitest of
# reader / mdJson / module_medium

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-20 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_medium'

class TestReaderMdJsonMedium < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Medium
   aIn = TestReaderMdJsonParent.getJson('medium.json')
   @@hIn = aIn['medium'][0]

   def test_medium_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'medium.json')
      assert_empty errors

   end

   def test_complete_medium_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:mediumSpecification]
      assert_equal 9.9, metadata[:density]
      assert_equal 'units', metadata[:units]
      assert_equal 9, metadata[:numberOfVolumes]
      assert_equal 2, metadata[:mediumFormat].length
      assert_equal 'mediumFormat0', metadata[:mediumFormat][0]
      assert_equal 'mediumFormat1', metadata[:mediumFormat][1]
      assert_equal 'note', metadata[:note]
      refute_empty metadata[:identifier]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_medium_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['mediumSpecification'] = {}
      hIn['density'] = ''
      hIn['units'] = ''
      hIn['numberOfVolumes'] = ''
      hIn['mediumFormat'] = []
      hIn['note'] = ''
      hIn['identifier'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

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

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['nonElement'] = ''
      hIn.delete('mediumSpecification')
      hIn.delete('density')
      hIn.delete('units')
      hIn.delete('numberOfVolumes')
      hIn.delete('mediumFormat')
      hIn.delete('note')
      hIn.delete('identifier')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

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

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson offline distribution medium object is empty'

   end

end
