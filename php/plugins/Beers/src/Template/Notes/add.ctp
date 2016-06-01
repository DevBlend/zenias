<nav class="large-3 medium-4 columns" id="actions-sidebar">
    <ul class="side-nav">
        <li class="heading"><?= __('Actions') ?></li>
        <li><?= $this->Html->link(__('List Notes'), ['action' => 'index']) ?></li>
        <li><?= $this->Html->link(__('List Beers'), ['controller' => 'Beers', 'action' => 'index']) ?></li>
        <li><?= $this->Html->link(__('New Beer'), ['controller' => 'Beers', 'action' => 'add']) ?></li>
    </ul>
</nav>
<div class="notes form large-9 medium-8 columns content">
    <?= $this->Form->create($note) ?>
    <fieldset>
        <legend><?= __('Add Note') ?></legend>
        <?php
            echo $this->Form->input('pseudo');
            echo $this->Form->input('text');
            echo $this->Form->input('note');
            echo $this->Form->input('beer_id', ['options' => $beers]);
        ?>
    </fieldset>
    <?= $this->Form->button(__('Submit')) ?>
    <?= $this->Form->end() ?>
</div>
