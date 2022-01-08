const Database = require('better-sqlite3');
const db = new Database('nh.db', { verbose: console.log,fileMustExist: true });
/*
const getMethods = (obj) => {
  let properties = new Set()
  let currentObj = obj
  do {
    Object.getOwnPropertyNames(currentObj).map(item => properties.add(item))
  } while ((currentObj = Object.getPrototypeOf(currentObj)))
  return [...properties.keys()].filter(item => typeof obj[item] === 'function')
}
*/
//console.log(getMethods(db));


//db.exec("CREATE TABLE IF NOT EXISTS mangas(id INT,title TEXT)");

//db.exec("INSERT INTO mangas VALUES (123, 'test')");

//const row = db.prepare('SELECT * FROM mangas').get();
//console.log(db.exec("SELECT * FROM sqlite_schema ;"));


const express = require('express')
const app = express()

// One of the following
async function getKey(key) {
	try {
		let dbKey = await keyv.get(key);
		return dbKey
	} catch (error)  {
		console.log("error")
		return "error"
	}
}

async function addVisitedManga(id, title) {
	await keyv.set(id, title)
}

app.get('/', function (req, res) {
  res.send('Hello World')
})

app.get('/addVisitedManga', function (req, res) {
	// + " < url=" + req.url
	console.log("adding: " + req.query.id + " = " + req.query.title)
  addVisitedManga(req.query.id, req.query.title)
	res.send("added")
})

app.get('/getManga', function (req, res) {
	row = db.exec("SELECT * FROM keyv where key in ('385100', '384649')");
	console.log(row);
	res.send(row);
	/*getKey(req.query.id).then( title => {
	  res.json({
		  "id": req.query.id,
		  "title": title
	  })*/
 
})

app.listen(3000);