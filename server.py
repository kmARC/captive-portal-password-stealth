from http.server import HTTPServer, SimpleHTTPRequestHandler

SimpleHTTPRequestHandler.extensions_map[''] = 'text/html'
SimpleHTTPRequestHandler.extensions_map['.txt'] = 'text/html'

httpd = HTTPServer(('10.0.0.1', 80), SimpleHTTPRequestHandler)

httpd.serve_forever()

