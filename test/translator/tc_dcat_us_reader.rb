# MdTranslator - minitest of
# adiwg / mdtranslator / mdReaders / dcat_us_reader

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require 'adiwg/mdtranslator/readers/dcat_us/version'

class TestDcatUsReader < Minitest::Test

   def test_dcat_us_reader_invalid_json

      metadata = ADIWG::Mdtranslator.translate(file: 'not valid json {{{', reader: 'dcat_us')

      refute_empty metadata
      assert_equal 'dcat_us', metadata[:readerRequested]
      refute metadata[:readerStructurePass]
      refute_empty metadata[:readerStructureMessages]

   end

   def test_dcat_us_reader_empty_object

      metadata = ADIWG::Mdtranslator.translate(file: '{}', reader: 'dcat_us')

      refute_empty metadata
      assert_equal 'dcat_us', metadata[:readerRequested]
      refute metadata[:readerStructurePass]
      refute_empty metadata[:readerStructureMessages]

   end

   def test_dcat_us_reader_full_catalog

      file = File.join(File.dirname(__FILE__), 'testData', 'dcat_us_catalog.json')
      json_str = File.read(file)

      metadata = ADIWG::Mdtranslator.translate(file: json_str, reader: 'dcat_us')

      refute_empty metadata
      assert_equal 'dcat_us', metadata[:readerRequested]
      assert metadata[:readerStructurePass]
      assert_empty metadata[:readerStructureMessages]

      intObj = metadata[:writerOutput] || metadata
      # Ensure the internal object has been populated
      refute_nil metadata[:readerExecutionPass]

   end

   def test_dcat_us_reader_single_dataset

      file = File.join(File.dirname(__FILE__), 'testData', 'dcat_us_single_dataset.json')
      json_str = File.read(file)

      metadata = ADIWG::Mdtranslator.translate(file: json_str, reader: 'dcat_us')

      refute_empty metadata
      assert_equal 'dcat_us', metadata[:readerRequested]
      assert metadata[:readerStructurePass]
      assert_empty metadata[:readerStructureMessages]

   end

   def test_dcat_us_reader_version
      assert_equal '0.1.0', ADIWG::Mdtranslator::Readers::Dcat_us::VERSION
   end

end
