# Increase log verbosity
log_level = "DEBUG"

data_dir = "/nomad/data/"

name = "client-fetcher"

# Enable the client
client {
  enabled = true
  meta = {
    "type" = "fetcher"
  }
  options = {
    "driver.raw_exec.enable" = "1"
  }
  servers = ["172.22.0.5:4647"]
}