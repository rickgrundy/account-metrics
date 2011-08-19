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
      <form action="/" method="post" enctype="multipart/form-data" id="uploadform">
        <input type="file" name="csv" onchange="document.getElementById('uploadform').submit();"/>
        <input type="submit" style="display: none;"/>
      </form>
      <div class="samples">
        <a href="/sample-input.csv">Sample Input</a> |
        <a href="/sample-output.png">Sample Output</a>
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
  attachment("#{data.title}.png")
  image.to_blob
end

get('/sample-input.csv') { send_file("samples/sample-input.csv", :disposition => "attachment", :filename => "sample-input.csv") }
get('/sample-output.png') { send_file("samples/sample-output.png", :disposition => "attachment", :filename => "sample-output.png") }