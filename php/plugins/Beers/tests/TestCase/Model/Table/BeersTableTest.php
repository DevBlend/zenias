<?php
namespace Beers\Test\TestCase\Model\Table;

use Beers\Model\Table\BeersTable;
use Cake\ORM\TableRegistry;
use Cake\TestSuite\TestCase;

/**
 * Beers\Model\Table\BeersTable Test Case
 */
class BeersTableTest extends TestCase
{

    /**
     * Test subject
     *
     * @var \Beers\Model\Table\BeersTable
     */
    public $Beers;

    /**
     * Fixtures
     *
     * @var array
     */
    public $fixtures = [
        'plugin.beers.beers',
        'plugin.beers.notes'
    ];

    /**
     * setUp method
     *
     * @return void
     */
    public function setUp()
    {
        parent::setUp();
        $config = TableRegistry::exists('Beers') ? [] : ['className' => 'Beers\Model\Table\BeersTable'];
        $this->Beers = TableRegistry::get('Beers', $config);
    }

    /**
     * tearDown method
     *
     * @return void
     */
    public function tearDown()
    {
        unset($this->Beers);

        parent::tearDown();
    }

    /**
     * Test initialize method
     *
     * @return void
     */
    public function testInitialize()
    {
        $this->markTestIncomplete('Not implemented yet.');
    }

    /**
     * Test validationDefault method
     *
     * @return void
     */
    public function testValidationDefault()
    {
        $this->markTestIncomplete('Not implemented yet.');
    }
}
