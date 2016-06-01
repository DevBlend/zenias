<?php
namespace Beers\Controller;

use Beers\Controller\AppController;

/**
 * Beers Controller
 *
 * @property \Beers\Model\Table\BeersTable $Beers
 */
class BeersController extends AppController
{

    /**
     * Index method
     *
     * @return \Cake\Network\Response|null
     */
    public function index()
    {
        $beers = $this->paginate($this->Beers);

        $this->set(compact('beers'));
        $this->set('_serialize', ['beers']);
    }

    /**
     * View method
     *
     * @param string|null $id Beer id.
     * @return \Cake\Network\Response|null
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function view($id = null)
    {
        $beer = $this->Beers->get($id, [
            'contain' => ['Notes']
        ]);

        $this->set('beer', $beer);
        $this->set('_serialize', ['beer']);
    }

    /**
     * Add method
     *
     * @return \Cake\Network\Response|void Redirects on successful add, renders view otherwise.
     */
    public function add()
    {
        $beer = $this->Beers->newEntity();
        if ($this->request->is('post')) {
            $beer = $this->Beers->patchEntity($beer, $this->request->data);
            if ($this->Beers->save($beer)) {
                $this->Flash->success(__('The beer has been saved.'));
                return $this->redirect(['action' => 'index']);
            } else {
                $this->Flash->error(__('The beer could not be saved. Please, try again.'));
            }
        }
        $this->set(compact('beer'));
        $this->set('_serialize', ['beer']);
    }

    /**
     * Edit method
     *
     * @param string|null $id Beer id.
     * @return \Cake\Network\Response|void Redirects on successful edit, renders view otherwise.
     * @throws \Cake\Network\Exception\NotFoundException When record not found.
     */
    public function edit($id = null)
    {
        $beer = $this->Beers->get($id, [
            'contain' => []
        ]);
        if ($this->request->is(['patch', 'post', 'put'])) {
            $beer = $this->Beers->patchEntity($beer, $this->request->data);
            if ($this->Beers->save($beer)) {
                $this->Flash->success(__('The beer has been saved.'));
                return $this->redirect(['action' => 'index']);
            } else {
                $this->Flash->error(__('The beer could not be saved. Please, try again.'));
            }
        }
        $this->set(compact('beer'));
        $this->set('_serialize', ['beer']);
    }

    /**
     * Delete method
     *
     * @param string|null $id Beer id.
     * @return \Cake\Network\Response|null Redirects to index.
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function delete($id = null)
    {
        $this->request->allowMethod(['post', 'delete']);
        $beer = $this->Beers->get($id);
        if ($this->Beers->delete($beer)) {
            $this->Flash->success(__('The beer has been deleted.'));
        } else {
            $this->Flash->error(__('The beer could not be deleted. Please, try again.'));
        }
        return $this->redirect(['action' => 'index']);
    }
}
