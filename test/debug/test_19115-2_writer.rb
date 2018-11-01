# MdTranslator - test example mdJson files with errors

# History:
#  Stan Smith 2018-10-31 original script

require_relative 'debug_test_parent'

class Test191152WriterDebug < TestDebugParent

   def test_ISO191152_writer

      # read the json input file
      mdJson = TestDebugParent.get_json('josh01')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true, forceValid: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      puts 'Structure Messages:'
      puts hResponseObj[:readerStructureMessages]

      puts 'Validation Messages:'
      puts hResponseObj[:readerValidationMessages]

      puts 'Reader Messages:'
      puts hResponseObj[:readerExecutionMessages]

      puts 'Writer Messages:'
      puts hResponseObj[:writerMessages]

      refute_nil xMetadata

   end

end
