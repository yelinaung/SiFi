require 'sinatra'

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

