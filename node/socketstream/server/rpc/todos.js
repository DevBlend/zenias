// Server-side code

// All the todos are stored in an in-memory array on the server
// This should not be done in production apps
var todos = [];
var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/node');

var todoSchema = mongoose.Schema({
	id : String,
	title : String,
	completed : Boolean
});

var TodoModel = mongoose.model('todo',todoSchema);

// Define actions which can be called from the client using
// ss.rpc('demo.ACTIONNAME', param1, param2...)
exports.actions = function (req, res, ss) {
	return {
		getAll: function () {
			if(todos.length > 0) {
				res(todos);
			} else {
				TodoModel.find({}, function (err, docs) {
					if(err) console.log(err);
					if(docs.length > 0) {
						todos = docs;
					}
					res(todos);
				})
			}
		},
		update: function (clientTodos) {
			todos = clientTodos;
			ss.publish.all('updateTodos', todos);
			if(todos.length > 0) {
				// remove existing todos
				// crude hack
				TodoModel.find({}).remove().exec();
				// save in mongoDB
				TodoModel.collection.insert(todos, function (err, docs) {
					if (err) console.log(err);
					console.log('todos inserted');
				})
			}
		}
	};
};
