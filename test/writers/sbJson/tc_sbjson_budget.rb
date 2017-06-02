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

   def test_citation

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = [
         {
            'className' => 'gov.sciencebase.catalog.item.facet.BudgetFacet',
            'annualBudgets' => [
               {
                  'fundingSources' => [
                     {
                        'amount' => 250.0,
                        'matching' => 'true',
                        'recipient' => 'bar1',
                        'source' => 'foo1'
                     },
                     {
                        'amount' => 250000.0,
                        'matching' => 'false'
                     }
                  ],
                  'year' => '2016'
               },
               {
                  'fundingSources' => [
                     {
                        'amount' => 500.0,
                        'matching' => 'true',
                        'recipient' => 'bar2',
                        'source' => 'foo2'
                     },
                     {
                        'amount' => 500000.0,
                        'matching' => 'false'
                     }
                  ],
                  'year' => '2017'
               }
            ]
         }
      ]
      
      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['facets']

      assert_equal expect, got

   end

end


