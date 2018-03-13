# MdTranslator - minitest of
# reader / mdJson / module_graphic

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-11 refactored for mdJson 2.0
#   Stan Smith 2015-06-22 refactored setup after removal of globals
#   Stan Smith 2014-12-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_graphic'

class TestReaderMdJsonGraphic < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Graphic
   aIn = TestReaderMdJsonParent.getJson('graphic.json')
   @@hIn = aIn['graphic'][0]

   def test_graphic_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'graphic.json')
      assert_empty errors

   end

   def test_complete_graphic_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'fileName', metadata[:graphicName]
      assert_equal 'fileDescription', metadata[:graphicDescription]
      assert_equal 'fileType', metadata[:graphicType]
      assert_equal 2, metadata[:graphicConstraints].length
      assert_equal 1, metadata[:graphicURI].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_graphic_fileName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['fileName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson reader: graphic overview file name is missing'

   end

   def test_missing_graphic_fileName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('fileName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson reader: graphic overview file name is missing'

   end

   def test_empty_graphic_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['fileDescription'] = ''
      hIn['fileType'] = ''
      hIn['fileConstraint'] = []
      hIn['fileUri'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:graphicDescription]
      assert_nil metadata[:graphicType]
      assert_empty metadata[:graphicConstraints]
      assert_empty metadata[:graphicURI]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_graphic_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('fileDescription')
      hIn.delete('fileType')
      hIn.delete('fileConstraint')
      hIn.delete('fileUri')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:graphicDescription]
      assert_nil metadata[:graphicType]
      assert_empty metadata[:graphicConstraints]
      assert_empty metadata[:graphicURI]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_graphic_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson reader: graphic overview object is empty'

   end

end
