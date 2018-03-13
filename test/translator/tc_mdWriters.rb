# MdTranslator - minitest of
# adiwg / mdtranslator / mdWriters

# History:
#  Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'

class TestMdWriters < MiniTest::Test

   # read in an mdJson 2.x file
   file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
   file = File.open(file, 'r')
   @@jsonObj = file.read
   file.close

   def test_mdWriters_invalid_writer

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonObj, writer: 'xxx'
      )

      refute_empty metadata
      assert_equal 'xxx', metadata[:writerRequested]
      refute metadata[:writerPass]
      refute_empty metadata[:writerMessages]

   end

end

