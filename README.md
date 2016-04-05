# server-12
To run the server, open up terminal and type irb -r ./server.rb
Then type WebServer.new.start 

To send requests, you can use both curl and the browser. To do it from curl, you use the command 
curl http://davidchau95:chau@localhost:56789 into your terminal. To do it from the browser, enter the url localhost:56789 into your browser. 

#Create requests
To create the various requests (using curl):

* Regular Get requests: curl http://davidchau95:chau@localhost:56789
* Alias'd Get requests: curl http://davidchau95:chau@localhost:56789/ab/
* Script-Aliased Get requests: curl http://davidchau95:chau@localhost:56789/cgi-bin/
* Delete Requests: curl -X DELETE http://davidchau95:chau@localhost:56789/{INSERT FILE HERE}
  where {INSERT FILE HERE} is a file you're trying to delete
