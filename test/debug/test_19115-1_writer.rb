# MdTranslator - test example mdJson files with errors

# History:
#  Stan Smith 2019-08-21 original script

require_relative 'debug_test_parent'

class Test191151WriterDebug < TestDebugParent

   def test_ISO191151_writer

      # read the json input file
      mdJson = TestDebugParent.get_json('schemaExample')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdJson, reader: 'mdJson', writer: 'iso19115_1', showAllTags: true, forceValid: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      File.write('/mnt/hgfs/ShareDrive/writeOut.xml', xMetadata)

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
