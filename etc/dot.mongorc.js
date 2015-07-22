/* Mongo shell ref: http://pt.slideshare.net/mongodb/hannes-shelltipsandtricks
 * embedded javascript interpreter, Spidermonkey/V8
 *
 * shortcuts: http://docs.mongodb.org/v2.6/reference/program/mongo/#mongo-keyboard-shortcuts
 * Ctrl+L: clear screen and redisplay line
 *
 * Loading scripts
 * * Commandline
 *  * --eval switch
 *  * .js files
 * * Within the shell
 *  * load()
 *
 * db.runCommand({...}) //against current db
 * db.adminCommand({...}) //against admin database
 *
 * printjson() -->tojson
 * forEach on arrays, queries, and cursors
 *   [{x: 1}, {y:1}].forEach(function(x){ printjson(x); })
 * Object.bsonsize(doc)
 * db.col1.stats()
 * load(file)
 * run(file)
 * ObjectId("...")
 * new Date()
 * new Date().toISOString()
 *
 * db.system.js.save({_id: "echoFunction", value: function(x){return x;}});
 * db.loadServerScripts();
 * echoFunction(3);
 *
 * edit a_func_name;
 *
 */

var host = db.serverStatus().host;
var prompt = function() { return db+"@"+host+"> "; }

// Common functions
function generate_test_data(dbname, colname, num){
  var col = db.getSiblingDB(dbname).getCollection(colname);
  for (i = 0; i < num; i++) {
    col.insert({name: 'name'+i, value: i, time: new Date()});
  }
  print(col.count());
}
function init_trydb(){
  //todo: check existed?
  generate_test_data("trydb", "notes", 200);
}

function show_indexes(){
  db.getCollectionNames().forEach(function(x){
    print("Collection:" + x);
    printjson(db[x].getIndexes());
  })
}

function biggest_doc(){
  var cursor = db.coll.find(); //FIXME
  var biggest = 0;
  var doc = {};
  cursor.forEach(function(x){
    var size = Object.bsonsize(x);
    if (size > biggest){
      biggest = size;
      doc = x;
    }
  })
  print(biggest);
  printjson(doc);
}

// Sharding
// sh.status()
// sh.enableSharding(dbname)

// Replica set
rs.slaveOk();
//rs.status()
//cfg = rs.config();
//rs.reconfig(cfg);
//db.isMaster()

/* Mongo query statements
 *
 * help
 * db
 * use ohter_db
 * show dbs
 * show collections
 * db.help()
 * db.col1.find()
 * db.col1.find({x: 18})
 * it
 * db.col1.findOne()
 * db.col1.find().limit(3)
 * db['col1'].count()
 *
 */
