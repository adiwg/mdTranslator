# MdTranslator - minitest of
# writers / fgdc / class_metadataInfo

# History:
#  Stan Smith 2018-01-27 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcMetadataInfo < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   def test_metadataInfo_complete

      # read the fgdc reference file
      xFile = TestWriterFGDCParent.get_xml('metadataInfo')
      expect = xFile.xpath('./metadata/metainfo').to_s.squeeze(' ')

      # build mdJson in hash
      mdHash = TDClass.base

      hLegal = TDClass.build_legalConstraint
      TDClass.add_accessConstraint(hLegal, 'metadata access constraint')
      TDClass.add_useConstraint(hLegal, 'metadata use constraint')
      mdHash[:metadata][:metadataInfo][:metadataConstraint] = []
      mdHash[:metadata][:metadataInfo][:metadataConstraint] << hLegal

      hSecurity = TDClass.build_securityConstraint('security classification',
                                                   'security classification system',
                                                   'security handling instructions')
      mdHash[:metadata][:metadataInfo][:metadataConstraint] << hSecurity

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('./metadata/metainfo').to_s.squeeze(' ')

      assert_equal expect, got

   end

end
