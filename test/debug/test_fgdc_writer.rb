# MdTranslator - test example mdJson files with errors

# History:
#  Stan Smith 2017-11-16 original script

require_relative 'debug_test_parent'

class TestFgdcWriterDebug < TestDebugParent

   def test_fgdc_writer

      # read the json input file
      mdJson = TestDebugParent.get_json('mdjson-20180205-120279')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdJson, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('./metadata')

      refute_nil got

   end

end
