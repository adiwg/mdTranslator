# mdJson 2.0 writer tests - resource info

# History:
#  Stan Smith 2018-06-07 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-15 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonResourceInfo < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hResInfo = mdHash[:metadata][:resourceInfo]

   # short abstract
   hResInfo[:shortAbstract] = 'short abstract'

   # credit []
   hResInfo[:credit] = []
   hResInfo[:credit] << 'credit one'
   hResInfo[:credit] << 'credit two'

   # point of contact [+]
   hResInfo[:pointOfContact] << TDClass.build_responsibleParty('pointOfContact', ['CID003'])

   # spatial reference system []
   hResInfo[:spatialReferenceSystem] = []
   hResInfo[:spatialReferenceSystem] << TDClass.build_spatialReference('WKT',nil,nil,'WKT')
   hResInfo[:spatialReferenceSystem] << TDClass.build_spatialReference('WKT',nil,nil,'WKT')

   # spatial representation type []
   hResInfo[:spatialRepresentationType] = []
   hResInfo[:spatialRepresentationType] << 'spatial representation type one'
   hResInfo[:spatialRepresentationType] << 'spatial representation type two'

   # spatial representation []
   hGrid = TDClass.build_gridRepresentation
   TDClass.add_dimension(hGrid)
   hSpaceRep = TDClass.build_spatialRepresentation('grid', hGrid)
   hResInfo[:spatialRepresentation] = []
   hResInfo[:spatialRepresentation] << hSpaceRep
   hResInfo[:spatialRepresentation] << hSpaceRep
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

   # spatial resolution []
   hResInfo[:spatialResolution] = []
   hResInfo[:spatialResolution] << TDClass.build_spatialResolution('scale')
   hResInfo[:spatialResolution] << TDClass.build_spatialResolution('detail')

   # temporal resolution []
   hResInfo[:temporalResolution] = []
   hResInfo[:temporalResolution] << TDClass.build_duration(1,6)
   hResInfo[:temporalResolution] << TDClass.build_duration(nil,nil,30)

   # extent [+]
   hResInfo[:extent] << TDClass.build_extent

   # coverage description []
   hResInfo[:coverageDescription] = []
   hResInfo[:coverageDescription] << TDClass.build_coverageDescription
   hResInfo[:coverageDescription] << TDClass.build_coverageDescription

   # taxonomy []
   hResInfo[:taxonomy] = []
   hResInfo[:taxonomy] << TDClass.build_taxonomy
   hResInfo[:taxonomy] << TDClass.build_taxonomy

   # graphic overview []
   hResInfo[:graphicOverview] = []
   hResInfo[:graphicOverview] << TDClass.build_graphic
   hResInfo[:graphicOverview] << TDClass.build_graphic

   # resource format []
   hResInfo[:resourceFormat] = []
   hResInfo[:resourceFormat] << TDClass.build_resourceFormat
   hResInfo[:resourceFormat] << TDClass.build_resourceFormat

   # keyword [+]
   hResInfo[:keyword] << hResInfo[:keyword][0]

   # resource usage []
   hResInfo[:resourceUsage] = []
   hResInfo[:resourceUsage] << TDClass.build_resourceUsage
   hResInfo[:resourceUsage] << TDClass.build_resourceUsage

   # constraint [+]
   hResInfo[:constraint] << hResInfo[:constraint][0]

   # other resource locale []
   hResInfo[:otherResourceLocale] = []
   hResInfo[:otherResourceLocale] << TDClass.build_locale
   hResInfo[:otherResourceLocale] << TDClass.build_locale

   # resource maintenance [+]
   hResInfo[:resourceMaintenance] << hResInfo[:resourceMaintenance][0]

   # environment description
   hResInfo[:environmentDescription] = 'environment description'

   # supplemental information
   hResInfo[:supplementalInfo] = 'supplemental information'

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   def test_schema_resourceInfo

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo]
      hTest[:resourceFormat].delete_at(0)
      hTest[:keyword].delete_at(0)
      hTest[:resourceUsage].delete_at(0)
      hTest[:topicCategory] = ['deprecated']
      errors = TestWriterMdJsonParent.testSchema(hTest, 'resourceInfo.json')
      assert_empty errors

   end

   def test_complete_resourceInfo

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'none',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']

      assert metadata[:writerPass]
      assert metadata[:readerStructurePass]
      assert metadata[:readerValidationPass]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:writerMessages]
      assert_empty metadata[:readerStructureMessages]
      assert_empty metadata[:readerValidationMessages]
      assert_empty metadata[:readerExecutionMessages]
      assert_equal expect, got

   end

end
