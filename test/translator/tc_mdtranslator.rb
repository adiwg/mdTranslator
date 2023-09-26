# MdTranslator - minitest of
# adiwg / mdtranslator
# adiwg / mdtranslator / mdReaders
# adiwg / mdtranslator / mdWriters

# History:
#   Stan Smith 2016-11-12 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'

class TestMdTranslator < Minitest::Test

   # read in an mdJson 2.x test file
   file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
   file = File.open(file, 'r')
   @@jsonObj = file.read
   file.close

   @@version = ADIWG::Mdtranslator::VERSION

   def test_mdtranslator_minimal_params

      # only 'file' is required
      # translate(file:, reader: 'mdJson', writer: nil, validate: 'normal', showAllTags: false, cssLink: nil)
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonObj
      )

      refute_empty metadata
      assert_equal 'mdJson', metadata[:readerRequested]
      assert_nil metadata[:writerRequested]
      assert_equal 'normal', metadata[:readerValidationLevel]
      refute metadata[:writerShowTags]
      assert_nil metadata[:writerCSSlink]
      assert_equal @@version, metadata[:translatorVersion]

   end

   def test_mdtranslator_all_params

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonObj, reader: 'mdJson', writer: 'html',
         validate: 'none', showAllTags: true, cssLink: 'http://example.com/my.css'
      )

      refute_empty metadata
      assert_equal 'mdJson', metadata[:readerRequested]
      assert_equal 'html', metadata[:writerRequested]
      assert_equal 'none', metadata[:readerValidationLevel]
      assert metadata[:writerShowTags]
      assert_equal 'http://example.com/my.css', metadata[:writerCSSlink]
      assert_equal @@version, metadata[:translatorVersion]

   end

   def test_mdtranslator_empty_reader_param

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonObj, reader: ''
      )

      refute_empty metadata
      assert_nil metadata[:readerRequested]
      refute metadata[:readerStructurePass]
      refute_empty metadata[:readerStructureMessages]

   end

end
