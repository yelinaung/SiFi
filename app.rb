require 'sinatra'

# redirect index to /files
get '/' do
  redirect to ('/files')
end

get '/dl/:filename' do |file|
  file = File.join('books',file)
  send_file(file, :disposition => 'attachment')
end

get '/files' do
    @files = Dir.glob('books/*')
    erb :index
end

