var express = require('express');
var session = require('express-session');
var app = express();
var multer = require('multer');
var mysql = require('mysql');
var path = require('path');
var bodyParser = require('body-parser');
var MongoClient = require("mongodb").MongoClient;
var nodemailer = require('nodemailer');
const { check, validationResult } = require('express-validator');
var urlencodedParser = bodyParser.urlencoded({ extended: false });
var cookieParser = require('cookie-parser');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
var url ='mongodb://localhost:27017';

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "12345678",
  database: "ofos",
  multipleStatements: true
});

app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));


app.use(express.static("template"));
app.get('/', function(request, response) {
	response.render(path.join("C:\\Users\\Goutham\\Desktop\\DBMS\\template\\index.ejs"));
});

var id;

app.post('/login', function(request, response) {
	var username = request.body.username;
	var password = request.body.password;
	if (username && password) {
		con.query('SELECT user_id,user_name FROM user WHERE user_name = ? AND password = ?', [username, password], function(error, results) {
			if (results.length > 0) {
				request.session.loggedin = true;
				request.session.username = username;
				id= results[0].user_id;
				response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\index_login.ejs',{results:results});
			} else {
				con.query('SELECT r.restaurant_id as restaurant_id,r.restaurant_name as restaurant_name,r.description as description,r.address as address,r.email as email,r.phone as phone FROM restaurant as r WHERE restaurant_name = ? AND password = ?', [username, password], function(error, res,fields) {
					if (res.length > 0) {
						request.session.loggedin = true;
						request.session.username = username;
						id = res[0].restaurant_id;
						response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\res_home.ejs',{res:res});	
					}else {
							response.send('Incorrect Username or Password!');
				          }
			         });
			   }		
		});
	} else {
		response.send('Please enter Username and Password!');
		response.end();
	}
});


app.post('/forgot', function(req, res) {
    con.query("use ofos;", function(err, result)  {
        if(err) throw err;
	});
    con.query("select user_name,password,email from user where User_name = ?; ",[req.body.uname], function(err, results)  {
		if(err) throw err;
		var transporter = nodemailer.createTransport({
			service: 'gmail',
			auth: {
			  user: 'gouthamg.k17@gmail.com',
			  pass: '!(@*#&$^%'
			}
		  });
		  
		  var mailOptions = {
			from: 'gouthamg.k17@gmail.com',
			to: results[0].email,
			subject: 'Forgot Password',
			text: "User Name: "+ results[0].user_name+" password: "+ results[0].password
		  };
		  
		  transporter.sendMail(mailOptions, function(error, info){
			if (error) {
			  res.send("Your mail is wrong or your user_name does not exist");
			} else {
				res.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\login.ejs');
			}
		  });
    }); 
});
app.get('/',function(req,res) {
    res.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\create.ejs');
});

function randomInt(low,high){
	return Math.floor(Math.random()*(high-low)+low);
}
app.post('/create',	urlencodedParser, function(req, res, next) {
    con.query("use ofos;", function(err, result)  {
        if(err) throw err;
	});

	var username = req.body.uname;
	var password = req.body.pwd;
		con.query('SELECT user_id FROM user WHERE user_name = ?', [username], function(error, results) {
			if (results.length > 0) {
				res.send(' Username already exists');
			} else {
				con.query('SELECT restaurant_id FROM restaurant WHERE restaurant_name = ?', [username], function(error, results) {
					if (results.length > 0) {
						res.send(' Username already exists');
					}else {
						if(req.body.select=="customer"){
							con.query("insert into user values('" 
																+ randomInt(9999,999999) + "','"
																+ req.body.uname + "','"
																+ req.body.address + "','"
																+ req.body.mobile + "','"
																+ req.body.email + "','"
																+ req.body.pwd + "');", function(err, result)  {
								if(err) throw err;
								console.log("Data inserted to user");
								});
								con.query('SELECT user_id,user_name FROM user WHERE user_name = ? AND password = ?', [username, password], function(error, results) {
										request.session.loggedin = true;
										request.session.username = username;
										id= results[0].user_id;
										response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\index_login.ejs',{results:results});
								});
						} else {
								con.query("insert into restaurant(restaurant_id,restaurant_name,address,phone,email,password) values('" 
																+ randomInt(9999,999999) + "','"
																+ req.body.uname + "','"
																+ req.body.address + "','"
																+ req.body.mobile + "','"
																+ req.body.email + "','"
																+ req.body.pwd + "');", function(err, result)  {
								if(err) throw err
								console.log("Data inserted to restaurant");
								});
								con.query('SELECT r.restaurant_id as restaurant_id,r.restaurant_name as restaurant_name,r.description as description,r.address as address,r.email as email,r.phone as phone FROM restaurant as r WHERE restaurant_name = ? AND password = ?', [username, password], function(error, results) {
										res.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\res_home.ejs',{results:results});
									 });
							}
				          }
			         });
			   }		
		});
});


app.get('/loadblog', function(req, res) {
    con.query("select b.blog_id as blog_id,r.restaurant_name as res_name,b.image_url as image_url,b.title as title,b.body as body from blog as b,restaurant as r where r.restaurant_id=b.res_id;select blog_id from likes where u_id = ? order by blog_id asc;",[id], function(err, results)  {
		if(err) throw err;
		res.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\blog.ejs',{results:results});
    }); 
});

app.get('/like/:bid', function(req, res) {
    con.query("insert into likes values(?,?);",[req.params.bid,id], function(err, results)  {
		if(err) throw err;
		con.query("update blog set likes= likes+1 where blog_id= ?;",[req.params.bid], function(err, results)  {
			if(err) throw err;
			res.redirect('/loadblog');
		});
    }); 
});

app.get('/dislike/:bid', function(req, res) {
    con.query("delete from likes where  blog_id=? and u_id=?;",[req.params.bid,id], function(err, results)  {
		if(err) throw err;
		con.query("update blog set likes= likes-1 where blog_id= ?;",[req.params.bid], function(err, results)  {
			if(err) throw err;
			res.redirect('/loadblog');
		});
    }); 
});

app.get('/loadmenu', function(req, res) {
    con.query("use ofos;", function(err, result)  {
        if(err) throw err;
	});
	con.query("select p.product_id as product_id, p.p_name as p_name,p.price as price,p.image_url as image_url from products as p;"+
	"SELECT p.product_id as product_id,count(o.order_id) as pop, p.p_name as p_name,p.price as price,p.image_url as image_url from products as p,total_orders as o where o.p_id = p.product_id and p.c_id='1' group by p.product_id order by pop desc limit 3;"+
	"SELECT p.product_id as product_id,count(o.order_id) as pop, p.p_name as p_name,p.price as price,p.image_url as image_url from products as p,total_orders as o where o.p_id = p.product_id and p.c_id='2' group by p.product_id order by pop desc limit 3;"+
	"SELECT p.product_id as product_id,count(o.order_id) as pop, p.p_name as p_name,p.price as price,p.image_url as image_url from products as p,total_orders as o where o.p_id = p.product_id and p.c_id='3' group by p.product_id order by pop desc limit 3;"+
	"SELECT p.product_id as product_id,count(o.order_id) as pop, p.p_name as p_name,p.price as price,p.image_url as image_url from products as p,total_orders as o where o.p_id = p.product_id and p.c_id='4' group by p.product_id order by pop desc limit 3;", function(err, results)  {
		if(err) throw err;
		res.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\menu.ejs',{results:results});
    }); 
});


app.get('/add/:pid', function(req, response) {
	var res_id;
	con.query("select res_id from products where product_id= ?;",[req.params.pid], function(err, res)  {
		if(err) throw err;
		res_id = res[0].res_id;
		con.query("insert into orders(p_id,u_id,res_id) values(?,?,?);",[req.params.pid,id,res_id], function(err, res)  {
			if(err) throw err;
			con.query("select max(order_id) as oid from orders",function(err,result){
			var oid = result[0].oid;
			const dbName = 'ofos';
			MongoClient.connect(url, function(err, client) {
				console.log("Connected successfully to server");
				const db = client.db(dbName);
				console.log(dbName);
			var pid = req.params.pid;		
			var data = { 
				"oid":oid,
				"pid": pid, 
				"uid": id, 
				"res_id": res_id
			} 
			db.collection('orders').insertOne(data,function(err, collection){ 
					if (err) throw err; 
					console.log("Record inserted Successfully");      
			}); 
			client.close();
		});
	});
			response.redirect('/loadmenu');
		});
	});
});

app.get('/deleteorder/:oid', function(req, response) {
	console.log(req.params.oid);
    con.query("delete from orders where u_id= ? and order_id= ?;",[id,req.params.oid], function(err, res)  {
		if(err) throw err;
		var oid = req.params.oid;
			const dbName = 'ofos';
			MongoClient.connect(url, function(err, client) {
				console.log("Connected successfully to server");
				const db = client.db(dbName);
				console.log(dbName);
					
			var data = { 
				"oid": oid
			} 
			db.collection('orders').remove(data,function(err, collection){ 
					if (err) throw err; 
					console.log("Record removed Successfully");      
			}); 
			client.close();
		});
		response.redirect('/ordered');
    });
});

app.get('/ordered', function(req, res) {
    con.query("use ofos;", function(err, result)  {
        if(err) throw err;
	});
    con.query("select sum(p.price) as total,count(p.product_id) as quant,p.product_id as product_id, p.p_name as p_name,p.price as price from products as p,orders as o where o.p_id=p.product_id and o.u_id=? group by p.product_id;",[id], function(err, results)  {
		if(err) throw err;
		res.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\user_order.ejs',{results:results});
    });
});

app.post('/bill', function(req, res) {
	con.query("Insert into bill(u_id) values (?);",[id], function(err, result)  {
        if(err) throw err;
	});
	con.query("insert into res_orders(order_id,p_id,u_id,res_id) select * from orders where u_id = ?;",[id], function(err, res)  {
		if(err) throw err;
	});
	con.query("insert into total_orders(order_id,p_id,u_id,res_id) select * from orders where u_id = ?;",[id], function(err, res)  {
		if(err) throw err;
	});
    con.query("select max(bill_id) as bill_id from bill where u_id=?;select sum(p.price) as total,count(p.product_id) as quant,p.product_id as product_id, p.p_name as p_name,p.price as price,p.image_url as image_url, o.res_id as res_id from products as p,orders as o where o.p_id=p.product_id and o.u_id=? group by p.product_id;",[id,id], function(err, result)  {
		if(err) throw err;
		console.log(result);
		res.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\bill.ejs',{result:result});
	});
	con.query("delete from orders where u_id = ?;",[id], function(err, res)  {
		if(err) throw err;
	});
});


app.post('/logout', function(request, response) {
	id=null;
	request.session.loggedin = false;
	response.render(path.join("C:\\Users\\Goutham\\Desktop\\DBMS\\template\\index.ejs"));
});


/*   Restaurant   side of the project 
*/
var storage = multer.diskStorage({
	destination: './template/images',
	filename: function(req,file,cb){
		  cb(null,file.fieldname + '-' + Date.now() + 
		  path.extname(file.originalname));
	}
});


app.get('/res_loadmenu', function(req, response) {
	var res_id = id;
    con.query("select product_id,p_name,price,image_url from products where res_id= ?;",[res_id], function(err, res)  {
		if(err) throw err;
		response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\res_menu.ejs',{res:res});
    });
});

app.get('/res_loadorder', function(req, response) {
	var res_id = id;
    con.query("select p.product_id as product_id,p.p_name as p_name,p.price as price,o.order_id as order_id from products as p,res_orders as o where o.p_id=p.product_id and o.res_id= ?;",[res_id], function(err, res)  {
		if(err) throw err;
		response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\orders.ejs',{res:res});
    });
});

app.post('/res_home', function(req, response) {
	var res_id = id;
    con.query("SELECT r.restaurant_id as restaurant_id,r.restaurant_name as restaurant_name,r.description as description,r.address as address,r.email as email,r.phone as phone FROM restaurant as r WHERE restaurant_id= ?;",[res_id], function(err, res)  {
		if(err) throw err;
		response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\Res_home.ejs',{res:res});
    });
});

app.post('/res_stat', function(req, response) {
	var res_id = id;
    con.query("select p.product_id as product_id,p.p_name as p_name, sum(p.price) as price,count(p.product_id) as quant,o.order_id as order_id from products as p,total_orders as o where o.p_id=p.product_id and o.res_id= ? group by p.product_id order by quant desc;",[res_id], function(err, res)  {
		if(err) throw err;
		response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\res_stats.ejs',{res:res});
    });
});

app.get('/res_loadmenu', function(req, response) {
	var res_id = id;
    con.query("select product_id,p_name,price,image_url from products where res_id= ?;",[res_id], function(err, res)  {
		if(err) throw err;
		response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\res_menu.ejs',{res:res});
    });
    
});

app.get('/delete/:pid', function(req, response) {
	var res_id = id;
	console.log(req.params.pid);
    con.query("delete from products where res_id= ? and product_id= ?;",[res_id,req.params.pid], function(err, results)  {
		if(err) throw err;
		response.redirect('/res_loadmenu');
    });
});


app.get('/deleteresorder/:oid', function(req, response) {
	console.log(req.params.oid);
    con.query("delete from res_orders where res_id= ? and order_id= ?;",[id,req.params.oid], function(err, results)  {
		if(err) throw err;
		response.redirect('/res_loadorder');
    });
});

app.get('/res_blog', function(req, response) {
	var res_id = id;
    con.query("select blog_id,title,likes from blog where res_id= ?;",[res_id], function(err, res)  {
		if(err) throw err;
		response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\res_blog.ejs',{res:res});
    });
    
});

app.get('/delete_blog/:bid', function(req, response) {
	var res_id = id;
	console.log(req.params.pid);
    con.query("delete from blog where res_id= ? and blog_id= ?;",[res_id,req.params.bid], function(err, results)  {
		if(err) throw err;
		response.redirect('/res_blog');
    });
});

app.post('/updateRes_details',function(req,response) {
	var name = req.body.name;
	var email = req.body.email;
	var phone = req.body.phone;
	var description=req.body.description;
	var address = req.body.address;
	con.query('update restaurant set restaurant_name= ?,description= ?,address= ?,email= ? ,phone= ?  WHERE restaurant_id= ? ', [name,description,address,email,phone,id], function(err, result,fields) {
		if(err) throw err;
		con.query('SELECT r.restaurant_id as restaurant_id,r.restaurant_name as restaurant_name,r.description as description,r.address as address,r.email as email,r.phone as phone FROM restaurant as r WHERE restaurant_id= ? ', [id], function(error, res,fields) {
			if (res.length > 0) {
				response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\res_home.ejs',{res:res});	
			}else {
					response.send('Incorrect Username or Password!');
				  }
			 });
		 });
});

// Upload menu

const upload = multer({
	storage: storage,
	fileFilter: function(req, file, cb){
		
		checkFileType(file, cb);
	}
 }).single('images')
 
 function checkFileType(file, cb){
 
	 const filetypes = /jpeg|jpg|png|gif/;
	 const extname = filetypes.test( path.extname(file.originalname).toLowerCase());
	 const mimetype = filetypes.test(file.mimetype);
 
	 if(mimetype && extname){
		 return cb(null,true);
	 } else{
		console.log("Images only!");
	 }
 }

 app.get('/res_blog', function(req, response) {
	var res_id = id;
    con.query("select blog_id,title,likes from blog where res_id= ?;",[res_id], function(err, res)  {
		if(err) throw err;
		response.render('C:\\Users\\Goutham\\Desktop\\DBMS\\template\\res_menu.ejs',{res:res});
    });
    
});

app.get('/delete_blog/:bid', function(req, response) {
	var res_id = id;
	console.log(req.params.pid);
    con.query("delete from blog where res_id= ? and blog_id= ?;",[res_id,req.params.bid], function(err, results)  {
		if(err) throw err;
		response.redirect('/res_blog');
    });
});

 
app.get('/updateblog',function(req,response) {
    upload(req,response,(err)=> {
		if(err){
			throw err;
		}else {
			if(req.file == undefined){
				response.send('error uploading');
		    } else {
				response.send( 'uploaded succesfully');
			}
		}
        con.query("insert into blog(res_id,image_url,title,body,likes) values(" 
				+ id + ",'"
				+ req.file.path.substring(req.file.path.lastIndexOf("\\")+1)+ "','"
				+ req.body.title + "','"
				+ req.body.body + "',0 );", function(err, result)  {
			if(err) throw err;
			console.log("Data inserted to blogs");
			var res_id = id;
			response.redirect('/res_blog');
			});
	});
});


app.post('/updateRes_menu',function(req,response) {
    upload(req,response,(err)=> {
		if(err){
			throw err;
		}else {
			if(req.file == undefined){
				response.send('error uploading');
		    } else {
				response.send( 'uploaded succesfully');
			}
		}
        con.query("insert into products values('" 
				+ randomInt(9999,999999) + "','"
				+ req.body.name + "','"
				+ req.body.price + "','"
				+ req.body.category + "','"
				+ id + "','"
				+ req.file.path.substring(req.file.path.lastIndexOf("\\")+1) + "');", function(err, result)  {
			if(err) throw err;
			console.log("Data inserted to products");
			var res_id = id;
			response.redirect('/res_loadmenu');
			});
	});
});


app.listen(8000, function () {
    console.log('Listening on port 8000');
});

con.connect(function(err) {
	if (err) throw err;
	console.log("Connected!");
  });


/* mongo db

router.get('/')

mongo.connect(url,functio(err,db){
	assert.equal(null, err);
	db.collection('user-data').insertOne(item,function(err))
})
*//*
app.post('/',function(req,res){
	const dbName = 'ofos';
	MongoClient.connect(url, function(err, client) {
		console.log("Connected successfully to server");
		const db = client.db(dbName);
		console.log(dbName);

		connection.query("INSERT INTO competition (com_title,com_details,com_judge,inst_id) VALUES('"
								+ req.body.com_title + "','"
								+ req.body.com_details + "','"
								+ req.body.com_judge + "','"
								+ in_id + "')", function(request,response){
					console.log('SQL Data inserted into competition table');
				});
		var pid = req.params.pid;		
		var data = { 
			"pid": pid, 
			"uid": id, 
			"res_id": res_id
		} 
		db.collection('orders').insertOne(data,function(err, collection){ 
				if (err) throw err; 
				console.log("Record inserted Successfully");      
		}); 
		client.close();
	});

});*/
