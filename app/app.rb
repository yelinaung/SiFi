require 'sinatra'
require 'sinatra/reloader'


def authorized?
  @auth ||=  Rack::Auth::Basic::Request.new(request.env)
  @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ["admin","admin"]
end

def protected!
  unless authorized?
    response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
    throw(:halt, [401, "Oops... we need your login name & password\n"])
  end
end

configure do
  set :public_folder, File.dirname(__FILE__) + '/public'
end

# redirect index to /files
get '/' do
  redirect to ('/files')
end

# downloads to be serverd via /dl/
get '/dl/:filename' do |file|
  file = File.join('books',file)
  send_file(file, :disposition => 'attachment')
end

# list all the files
get '/files' do
  @files = Dir.glob('books/*')
  erb :index
end

# filter by file type
get '/files/:filetype' do
  @files = Dir.glob("books/*.#{params[:filetype]}")
  erb :index
end

# Upload
get '/upload' do
  protected!
  erb :upload
end

# Handle the POST request
post '/upload' do
  tempfile = params['file'][:tempfile]
  filename = params['file'][:filename]
  upload_path = "books/#{filename}"
  File.open(upload_path, 'wb') {|f| f.write tempfile.read }
  redirect '/files'
end
