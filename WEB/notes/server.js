var Pusher = require('pusher');
var http = require('http');
var fs = require('fs');

var indexHtmlFileName = './index.html';
var port = 8085

085;

var pusher = new Pusher({
  appId: '616900',
  key: 'c48b41985e31debb63b1',
  secret: '1fa6dcf895e5d42c32a6',
  cluster: 'eu',
  encrypted: true
});

var server = http.createServer(OnRequest);


var favicon = fs.readFileSync('./favicon.ico');






server.listen(port);
console.log('Server running at http://127.0.0.1:8085/');





  
function OnRequest(request, response)
{
  console.log('request received:');
  console.log(request.method);
  //console.log(request.headers);
  console.log(request.url);
  switch(request.url)
  {
    case '/':
      {
        var fileContent = fs.readFileSync(indexHtmlFileName);
        response.writeHead(200, {'Content-Type': 'text/html; charset=utf8'});
        response.end(fileContent);
        
      }break;
    case '/favicon.ico':
    {
      response.writeHead(200, {'Content-Type': 'image/ico; charset=utf8'});
      response.end(favicon);
      
    }break;

    case '/styles.css':
    {
      var fileContent = fs.readFileSync('./styles.css');
      response.writeHead(200, {'Content-Type': 'text/css; charset=utf8'});
      response.end(fileContent);
      
    }break;
    case '/client.js':
    {
      var fileContent = fs.readFileSync('./client.js');
      response.writeHead(200,{'Content-Type' : 'text/js; charset=utf8'});
      response.end(fileContent);

      
    }break;
    
    case '/push':
    {
      response.writeHead(200, {'Content-Type': 'text/js; charset=utf8'});
      response.end();
      Push();
      
    }break;
    

      default:
        {
          response.writeHead(404);
          response.end();
        }
    }
    console.log('returned');
}




function Push()
{
    pusher.trigger('my-channel', 'my-event', {
        "message": "hello world"
      });
}