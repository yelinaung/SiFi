require 'sinatra'

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

get '/files/pdf' do
  @files = Dir.glob('books/*.pdf')
  erb :index
end

get '/files/epub' do
  @files = Dir.glob('books/*.epub')
  erb :index
end

get '/files/mobi' do
  @files = Dir.glob('books/*.mobi')
  erb :index
end

