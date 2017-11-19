# MdTranslator - minitest of
# writers / fgdc / class_citation

# History:
#   Stan Smith 2017-11-17 original script

require 'minitest/autorun'
require 'json'
require 'rubygems'
require 'adiwg/mdtranslator'
require_relative 'fgdc_test_parent'

class TestWriterFgdcCitation < TestReaderFgdcParent

   # read the mdJson 2.0 file
   @@mdJson = TestReaderFgdcParent.get_file('citation.json')

   def test_fgdc

      # read the fgdc reference file
      xFile = TestReaderFgdcParent.get_xml('citation.xml')
      xExpect = xFile.xpath('./metadata/idinfo/citation')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/idinfo/citation')

      assert_equal xExpect.to_s.squeeze, xGot.to_s.squeeze

   end

end
