# MdTranslator - minitest of
# reader / mdJson / module_format

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-20 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_format'

class TestReaderMdJsonFormat < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Format
   aIn = TestReaderMdJsonParent.getJson('format.json')
   @@hIn = aIn['format'][0]

   # TODO reinstate after schema update
   # def test_format_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'format.json')
   #     assert_empty errors
   #
   # end

   def test_complete_format_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:formatSpecification]
      assert_equal 'amendmentNumber', metadata[:amendmentNumber]
      assert_equal 'compressionMethod', metadata[:compressionMethod]
      assert_equal 'formatTechnicalPrerequisite', metadata[:technicalPrerequisite]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_format_empty_specification

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['formatSpecification'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson distribution media format specification is missing'

   end

   def test_format_missing_specification

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('formatSpecification')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson distribution media format specification is missing'

   end

   def test_format_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['amendmentNumber'] = ''
      hIn['compressionMethod'] = ''
      hIn['technicalPrerequisite'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:formatSpecification]
      assert_nil metadata[:amendmentNumber]
      assert_nil metadata[:compressionMethod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_format_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('amendmentNumber')
      hIn.delete('compressionMethod')
      hIn.delete('technicalPrerequisite')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:formatSpecification]
      assert_nil metadata[:amendmentNumber]
      assert_nil metadata[:compressionMethod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_format_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: distribution media format object is empty'

   end

end
