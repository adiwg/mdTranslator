# MdTranslator - minitest of
# reader / mdJson / module_contentInformation

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-18 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_coverageDescription'

class TestReaderMdJsonCoverageDescription < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::CoverageDescription
   aIn = TestReaderMdJsonParent.getJson('coverageDescription.json')
   @@hIn = aIn['coverageDescription'][0]

   def test_contentInfo_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'coverageDescription.json')
      assert_empty errors

   end

   def test_complete_contentInfo_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'coverageName', metadata[:coverageName]
      assert_equal 'coverageDescription', metadata[:coverageDescription]
      refute_empty metadata[:processingLevelCode]
      assert_equal 2, metadata[:attributeGroups].length
      refute_empty metadata[:imageDescription]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_contentInfo_empty_coverageName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['coverageName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: coverage description name is missing'

   end

   def test_contentInfo_missing_coverageName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('coverageName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: coverage description name is missing'

   end

   def test_contentInfo_empty_coverageDescription

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['coverageDescription'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: coverage description description is missing'

   end

   def test_contentInfo_missing_coverageDescription

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('coverageDescription')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: coverage description description is missing'

   end

   def test_contentInfo_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['processingLevelCode'] = {}
      hIn['attributeGroup'] = []
      hIn['imageDescription'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'coverageName', metadata[:coverageName]
      assert_equal 'coverageDescription', metadata[:coverageDescription]
      assert_empty metadata[:processingLevelCode]
      assert_empty metadata[:attributeGroups]
      assert_empty metadata[:imageDescription]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_contentInfo_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('processingLevelCode')
      hIn.delete('attributeGroup')
      hIn.delete('imageDescription')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'coverageName', metadata[:coverageName]
      assert_equal 'coverageDescription', metadata[:coverageDescription]
      assert_empty metadata[:processingLevelCode]
      assert_empty metadata[:attributeGroups]
      assert_empty metadata[:imageDescription]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_contentInformation_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: mdJson reader: coverage description object is empty'

   end

end
