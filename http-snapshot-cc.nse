description = [[ 
Attempt to take a snapshot of the remote host if it runs a web server. 
Based on the original SpiderLabs http-screenshot.nse. Requires CutyCapt,
with fixes included.
]]

author = "Jerold H. -- http://v00d00sec.com"
license = "Same as nmap -- http://nmap.org/book/man-legal.html"

categories = {"discovery", "safe"}

local http   = require 'http'
local stdnse = require 'stdnse'

portrule = function(host,port)
	local svc = { std = { ["http"] = 1, ["http-alt"] = 1 },
	              ssl = { ["https"] = 1, ["https-alt"] = 1 }
	            }

	-- If != TCP port, do not run.
	if port.protocol ~= 'tcp'
	   or not ( svc.std[port.service] or svc.ssl[port.service] ) then
	   	stdnse.print_debug( 1, "Not an acceptable TCP port (http, http-alt, https, or https-alt.)" )
		return false
	end

	-- If != SSL, do not run.
	if (svc.ssl[port.service] or port.version.service_tunnel == 'ssl')
	   and not nmap.have_ssl() then
	   	stdnse.print_debug( 1, "No SSL support." )
		return false
	end
	return true
end

action = function(host, port)
	
	local svc = { std = { ["http"] = 1, ["http-alt"] = 1 },
	              ssl = { ["https"] = 1, ["https-alt"] = 1 }
	            }

	-- Default URLs will start with http://
	local protocol = "http://"

	-- If SSL is set on the port, switch the protocol.
	if (svc.ssl[port.service] or port.version.service_tunnel == 'ssl') then
		protocol = "https://"	
	end

	-- Snapshots will be named snap-<IP>:<port>.png
        local output =  host.ip .. ":" .. port.number .. "-cc.png"

	-- Execute the command using CutyCapt
	local cmd = "CutyCapt --max-wait=5000 --delay=2500 --url=" .. protocol .. host.ip .. ":" .. port.number .. " --out=" .. output .. ""
	local ret = os.execute(cmd)

	local result = "Completed with errors"

	if ret then
		result = "Snapshot saved to " .. output
	end

	-- Return the output message
	return stdnse.format_output(true,  result)

end
