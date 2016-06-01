<?php
use Migrations\AbstractMigration;
use Cake\ORM\TableRegistry;

class CreateBeers extends AbstractMigration
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
        $table = $this->table('beers', ['id' => false, 'primary_key' => ['id']]);
        $table->addColumn('id', 'integer', [
            'autoIncrement' => true,
            'limit' => 11
        ]);
        $table->addColumn('name', 'string', [
            'default' => null,
            'limit' => 255,
            'null' => false,
        ]);
        $table->addColumn('description', 'text', [
            'default' => null,
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

        $BeerTable = TableRegistry::get('Beers');
        $data=[
          ['name'=>'A Lipsum Beer', 'description'=>'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam sem ante, commodo sed sagittis at, fermentum eu mi. Nam tincidunt semper viverra. Duis aliquam tortor at pharetra aliquet. In eu fermentum libero, in pharetra odio. In ullamcorper, nisl ac cursus aliquam, lacus augue fermentum justo, pretium sollicitudin arcu diam sed massa. Aenean id nisi semper, gravida lacus id, condimentum quam. Suspendisse potenti. Fusce nec nisi nulla.', 'created'=>'2016-05-31 19:20:00', 'modified'=>'2016-05-31 19:20:00'],
          ['name'=>'A Dolor Beer', 'description'=>'Aliquam imperdiet posuere massa. Pellentesque posuere ipsum tortor, ut ultricies neque laoreet in. Nullam nec ornare dui, tempus fermentum ex. Curabitur sit amet interdum nulla. Sed volutpat luctus sollicitudin. Vivamus nec tellus sit amet lorem fringilla eleifend. Pellentesque vehicula viverra tincidunt. Pellentesque ut diam vel leo scelerisque venenatis.', 'created'=>'2016-05-31 19:21:00', 'modified'=>'2016-05-31 19:21:00'],
          ['name'=>'A Sit Beer', 'description'=>'Vivamus aliquam purus in molestie venenatis. Fusce augue velit, efficitur nec feugiat in, iaculis eu tellus. Quisque vehicula nibh lectus, faucibus bibendum urna ultricies non. Donec tempus porttitor odio, eu imperdiet risus placerat eu. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. In ligula metus, aliquam at rutrum a, gravida quis dui. Mauris euismod magna eget nulla pellentesque, eu tristique purus cursus. Donec pellentesque sit amet sem eu facilisis. Mauris id orci vitae enim pretium accumsan eu a arcu. Donec tempus sit amet massa et feugiat. Sed dignissim iaculis nunc. Quisque nisl ex, accumsan sed feugiat eu, facilisis id nunc. Ut sit amet magna quis purus consectetur ullamcorper eget tempor ante.', 'created'=>'2016-05-31 19:22:00', 'modified'=>'2016-05-31 19:22:00'],
          ['name'=>'An Amet Beer', 'description'=>'Aenean aliquet viverra mi non dapibus. Ut laoreet enim vitae mi euismod, tincidunt ullamcorper turpis rhoncus. Nam lacinia varius libero, non malesuada nunc suscipit at. Maecenas et nunc sed justo rhoncus lobortis. Curabitur consectetur gravida risus, non mollis eros laoreet id. Suspendisse tristique nulla eu varius placerat. Aliquam ex enim, tempus sit amet ipsum a, imperdiet posuere neque. Proin in elementum magna. Ut vitae ipsum rhoncus, ultrices purus at, condimentum nisi. Nam volutpat mollis justo in rhoncus.', 'created'=>'2016-05-31 19:23:00', 'modified'=>'2016-05-31 19:23:00'],
          ['name'=>'Another Beer', 'description'=>'This is a reaaaaaly good beer', 'created'=>'2016-05-31 19:24:00', 'modified'=>'2016-05-31 19:24:00'],
        ];
        foreach($data as $b){
          $beer = $BeerTable->newEntity();
          //$beer->id=$b['id'];
          $beer->name=$b['name'];
          $beer->description=$b['description'];
          $beer->created=$b['created'];
          $beer->modified=$b['modified'];
          $BeerTable->save($beer);
        }
    }
}
