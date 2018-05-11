# MdTranslator - test example mdJson files with errors

# History:
#  Stan Smith 2017-11-16 original script

require_relative 'debug_test_parent'

class TestFgdcWriterDebug < TestDebugParent

   def test_fgdc_writer

      # read the json input file
      mdJson = TestDebugParent.get_json('dennis01')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdJson, reader: 'mdJson', writer: 'fgdc', showAllTags: true, forceValid: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('./metadata')

      puts 'Structure Messages:'
      puts hResponseObj[:readerStructureMessages]

      puts 'Validation Messages:'
      puts hResponseObj[:readerValidationMessages]

      puts 'Reader Messages:'
      puts hResponseObj[:readerExecutionMessages]

      puts 'Writer Messages:'
      puts hResponseObj[:writerMessages]

      refute_nil got

   end

end
