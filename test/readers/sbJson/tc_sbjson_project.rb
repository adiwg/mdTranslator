# MdTranslator - minitest of
# reader / sbJson / module_project

# History:
#   Stan Smith 2017-06-27 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_project'

class TestReaderSbJsonProject < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Project
   @@hIn = TestReaderSbJsonParent.getJson('project.json')

   def test_complete_project

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResourceInfo =  @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_equal 1, metadata[:status].length
      assert_equal 'onGoing', metadata[:status][0]
      assert_equal 'Precipitation has affected forest.', metadata[:shortAbstract]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_project_empty_parts

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['parts'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResourceInfo =  @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_nil metadata[:shortAbstract]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_project_missing_parts

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('parts')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hResourceInfo =  @@intMetadataClass.newResourceInfo

      metadata = @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_nil metadata[:shortAbstract]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
