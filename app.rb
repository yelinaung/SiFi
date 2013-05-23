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

get '/files' do
  @files = Dir.glob('books/*')
  erb :index
end


get '/files/:filetype' do
  @files = Dir.glob("books/*.#{params[:filetype]}")
  erb :index
end

# Upload
get '/upload' do
  "This is upload!"
end
