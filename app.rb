require 'sinatra'
require 'sinatra/reloader'

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
