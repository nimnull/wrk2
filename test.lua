-- requests = require('requests')
local base64 = require('base64')

username = "admin@datarobot.com"
token = "dC8_ULCqcrv23ffAt0_zCRD0r5ft8wjC"
PROJECT_ID = '583c39a8e8cb9159efe64c01'
MODEL_ID = '583c3c8fe8cb915cda9a8cb3'
data_file = nil

-- auth = requests.HTTPBasicAuth(username, token)

-- local filename = "temperatura_predict.csv"
-- local f = assert(io.open(filename, "r"))
-- local content = f:read("*all")
-- f:close()
-- print(content)

-- wrk.method = "POST"
-- wrk.headers["Content-Type"] = 'text/plain; encoding=UTF-8'
-- response = requests.post(uri, {data = data, auth = auth, headers = headers})
-- json_body, error = response.json()


function init(args)
    if #args > 0 then
        local code, result = pcall(function()
                handle = io.open(args[1])
                data_file = handle:read("*all")
            end)
    end
end

request = function()
    if not data_file then
        return wrk.path
    end
    -- local f = assert(io.open(filename, "r"))
    headers = {
        ["Content-Type"] = "text/plain; encoding=UTF-8",
        ["Authorization"] = "Basic " .. base64.encode(string.format("%s:%s", username, token))
    }

    local path = "http://10.0.0.2/api/v1/%s/%s/predict"
    return wrk.format("POST", path:format(PROJECT_ID, MODEL_ID), headers, data_file)
    -- method, path, headers, body
end
