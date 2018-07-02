# MdTranslator - minitest of
# reader / mdJson / module_graphic

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-11 refactored for mdJson 2.0
#  Stan Smith 2015-06-22 refactored setup after removal of globals
#  Stan Smith 2014-12-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_graphic'

class TestReaderMdJsonGraphic < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Graphic

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.graphic
   mdHash[:fileConstraint] << TDClass.useConstraint
   mdHash[:fileConstraint] << TDClass.useConstraint
   mdHash[:fileUri] << TDClass.build_onlineResource('https://adiwg.org/1')
   mdHash[:fileUri] << TDClass.build_onlineResource('https://adiwg.org/2')

   @@mdHash = mdHash

   def test_graphic_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'graphic.json')
      assert_empty errors

   end

   def test_complete_graphic_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'graphic file name', metadata[:graphicName]
      assert_equal 'graphic description', metadata[:graphicDescription]
      assert_equal 'graphic type', metadata[:graphicType]
      assert_equal 2, metadata[:graphicConstraints].length
      assert_equal 2, metadata[:graphicURI].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_graphic_fileName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['fileName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: graphic overview file name is missing: CONTEXT is testing'

   end

   def test_missing_graphic_fileName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('fileName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: graphic overview file name is missing: CONTEXT is testing'

   end

   def test_empty_graphic_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['fileDescription'] = ''
      hIn['fileType'] = ''
      hIn['fileConstraint'] = []
      hIn['fileUri'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:graphicDescription]
      assert_nil metadata[:graphicType]
      assert_empty metadata[:graphicConstraints]
      assert_empty metadata[:graphicURI]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_graphic_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('fileDescription')
      hIn.delete('fileType')
      hIn.delete('fileConstraint')
      hIn.delete('fileUri')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:graphicDescription]
      assert_nil metadata[:graphicType]
      assert_empty metadata[:graphicConstraints]
      assert_empty metadata[:graphicURI]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_graphic_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: graphic overview object is empty: CONTEXT is testing'

   end

end
