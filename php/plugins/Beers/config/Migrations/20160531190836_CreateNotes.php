<?php
use Migrations\AbstractMigration;
use Cake\ORM\TableRegistry;

class CreateNotes extends AbstractMigration
{
    public $autoId = false;
    /**
     * Up Method.
     *
     * More information on this method is available here:
     * http://docs.phinx.org/en/latest/migrations.html#the-up-method
     * @return void
     */
    public function up()
    {
        $table = $this->table('notes', ['id' => false, 'primary_key' => ['id']]);
        $table->addColumn('id', 'integer', [
            'autoIncrement' => true,
            'limit' => 11
        ]);
        $table->addColumn('pseudo', 'string', [
            'default' => null,
            'limit' => 255,
            'null' => false,
        ]);
        $table->addColumn('text', 'text', [
            'default' => null,
            'null' => false,
        ]);
        $table->addColumn('note', 'integer', [
            'default' => null,
            'limit' => 11,
            'null' => false,
        ]);
        $table->addColumn('beer_id', 'integer', [
            'default' => null,
            'limit' => 11,
            'null' => false,
        ]);
        $table->addColumn('created', 'datetime', [
            'default' => null,
            'null' => false,
        ]);
        $table->addColumn('modified', 'datetime', [
            'default' => null,
            'null' => false,
        ]);
        $table->create();

        $NotesTable = TableRegistry::get('Notes');
        $data=[
          ['pseudo'=>'BeerLover', 'text'=>'Yep, not bad', 'note'=>8, 'beer_id'=>1, 'created'=>'2016-05-31 19:31:00', 'modified'=>'2016-05-31 19:31:00'],
          ['pseudo'=>'Anonymous', 'text'=>'Looks like water, tastes like water.', 'note'=>0, 'beer_id'=>2, 'created'=>'2016-05-31 19:32:00', 'modified'=>'2016-05-31 19:32:00'],
          ['pseudo'=>'GoodTaste', 'text'=>'This is in fact, a pretty awesome beverage', 'note'=>7, 'beer_id'=>3, 'created'=>'2016-05-31 19:33:00', 'modified'=>'2016-05-31 19:33:00'],
          ['pseudo'=>'ADMIN', 'text'=>'Not bad, but not good. Too long description.', 'note'=>5, 'beer_id'=>2, 'created'=>'2016-05-31 19:34:00', 'modified'=>'2016-05-31 19:34:00'],
          ['pseudo'=>'Kitty75', 'text'=>'idk, ws prety goOd.', 'note'=>7, 'beer_id'=>4, 'created'=>'2016-05-31 19:35:00', 'modified'=>'2016-05-31 19:35:00'],
          ['pseudo'=>'ImKidding', 'text'=>'I love it !', 'note'=>3, 'beer_id'=>1, 'created'=>'2016-05-31 19:36:00', 'modified'=>'2016-05-31 19:36:00'],
        ];

        foreach($data as $n){
          $note = $NotesTable->newEntity();
          //$note->id=$n['id'];
          $note->pseudo=$n['pseudo'];
          $note->text=$n['text'];
          $note->note=$n['note'];
          $note->beer_id=$n['beer_id'];
          $note->created=$n['created'];
          $note->modified=$n['modified'];
          $NotesTable->save($note);
        }
    }
}
