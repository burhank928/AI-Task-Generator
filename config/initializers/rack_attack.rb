class Rack::Attack
  throttle("requests by ip", limit: 5, period: 60.seconds) do |req|
    req.ip if req.path == "/tasks/generate" && req.post?
  end

  self.throttled_response = lambda do |env|
    if env["REQUEST_PATH"] == "/tasks/generate" && env["REQUEST_METHOD"] == "POST"
      [ 429, { "Content-Type" => "text/vnd.turbo-stream.html" }, [ <<-ERB
        <turbo-stream action="replace" target="error-message">
          <template>
            <div id="error-message">
              <div class="alert alert-danger">Rate limit exceeded. Try again later.</div>
            </div>
          </template>
        </turbo-stream>
      ERB
      ] ]
    else
      [ 429, { "Content-Type" => "application/json" }, [ { error: "Rate limit exceeded. Try again later." }.to_json ] ]
    end
  end
end
