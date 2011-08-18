require 'rubygems'
require 'sinatra'
require 'csv'
require 'fileutils'
Dir.glob(File.join("app", "**", "*.rb")).each { |f| require File.expand_path(f) }

get '/' do
  <<-EOS
  <html>
    <head>
      <title>Account Metrics</title>
      <style>
      body {
        padding-top: 200px;
        width: 350px;
        margin: 0 auto;
        font-family: arial;
        color: #333;
      }
      a {
        color: #333;
      }
      form {
        margin: 2em 0;
      }
      div.samples {
        text-align: right;
        font-size: 0.8em;
      }
      </style>
    </head>
    <body>
      <h1>
        Upload a CSV file.
        <br/>
        Receive Metrics.
      </h1>
      <form action="/" method="post" enctype="multipart/formdata" id="uploadform">
        <input type="file" name="csv" onchange="document.getElementById('uploadform').submit();"/>
        <input type="submit" style="display: none;"/>
      </form>
      <div class="samples">
        <a href="/sample-input">Sample Input</a> |
        <a href="/sample-output">Sample Output</a>
      </div>
    </body>
  </html>
  EOS
end

post '/' do
  csv = CSV.parse(params[:csv][:tempfile].read)
  data = InputData.new(csv)
  image = Canvas.new(data).render
  image.format = "png"
  content_type "image/png"
  image.to_blob
end

get '/sample-input' do
  send_file("samples/input.csv")
end