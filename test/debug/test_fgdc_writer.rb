# MdTranslator - test example mdJson files with errors

# History:
#  Stan Smith 2017-11-16 original script

require_relative 'debug_test_parent'

class TestFgdcWriterDebug < TestDebugParent

   def test_fgdc_writer

      # read the json input file
      mdJson = TestDebugParent.get_json('schemaExample')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdJson, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('./metadata')

      puts 'Structure Messages:'
      unless hResponseObj[:readerStructurePass]
         puts hResponseObj[:readerStructureMessages]
      end

      puts 'Validation Messages:'
      unless hResponseObj[:readerValidationPass]
         puts hResponseObj[:readerValidationMessages]
      end

      puts 'Reader Messages:'
      unless hResponseObj[:readerExecutionPass]
         puts hResponseObj[:readerExecutionMessages]
      end

      puts 'Writer Messages:'
      unless hResponseObj[:writerPass]
         puts hResponseObj[:writerMessages]
      end

      refute_nil got

   end

end
