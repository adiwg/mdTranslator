# MdTranslator - test example mdJson files with errors

# History:
#  Stan Smith 2018-09-05 original script

require_relative 'debug_test_parent'

class TestFgdcReaderDebug < TestDebugParent

   def test_fgdc_reader

      # read the json input file
      xmlFile = TestDebugParent.get_xml('gulkanaGlacierGPR')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: xmlFile, reader: 'fgdc', writer: 'html', showAllTags: true, forceValid: true
      )

      htmlOut = hResponseObj[:writerOutput]
      File.write('/mnt/hgfs/ShareDrive/writeOut.html', htmlOut)

      puts 'Structure Messages:'
      puts hResponseObj[:readerStructureMessages]

      puts 'Validation Messages:'
      puts hResponseObj[:readerValidationMessages]

      puts 'Reader Messages:'
      puts hResponseObj[:readerExecutionMessages]

      puts 'Writer Messages:'
      puts hResponseObj[:writerMessages]

      refute_nil htmlOut

   end

end
