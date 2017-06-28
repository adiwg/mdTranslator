# sbJson 1 writer tests - budget

# History:
#  Stan Smith 2017-06-02 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonBudget < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('budget.json')

   def test_complete_budgetFacet

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = {
         'className' => 'gov.sciencebase.catalog.item.facet.BudgetFacet',
         'annualBudgets' => [
            {
               'fundingSources' => [
                  {
                     'amount' => 9.0,
                     'matching' => 'true',
                     'recipient' => 'Person 002',
                     'source' => 'Person 001'
                  },
                  {
                     'amount' => 90.0,
                     'matching' => 'false'
                  }
               ],
               'totalFunds' => 99.0,
               'year' => '2017'
            },
            {
               'fundingSources' => [
                  {
                     'amount' => 900.0,
                     'matching' => 'true',
                     'recipient' => 'Person 002',
                     'source' => 'Person 001'
                  },
                  {
                     'amount' => 9000.0,
                     'matching' => 'false'
                  }
               ],
               'totalFunds' => 9900.0,
               'year' => '2017'
            },
            {
               'year' => '2014'
            },
            {
               'year' => '2015'
            },
            {
               'fundingSources' => [
                  {
                     'amount' => 90000.0,
                     'matching' => 'false'
                  }
               ],
               'totalFunds' => 90000.0
            }
         ]
      }

      hJsonOut = JSON.parse(metadata[:writerOutput])
      aGot = hJsonOut['facets']
      got = {}
      aGot.each do |hGot|
         if hGot['className'] == 'gov.sciencebase.catalog.item.facet.BudgetFacet'
            got = hGot
         end
      end
      File.write('/mnt/hgfs/ShareDrive/writeOut.json', hJsonOut.to_json)

      assert_equal expect, got

   end

end


