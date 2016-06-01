<?php
use Cake\Routing\RouteBuilder;
use Cake\Routing\Router;

Router::plugin(
    'Beers',
    ['path' => '/beers'],
    function (RouteBuilder $routes) {
        $routes->fallbacks('DashedRoute');
    }
);
