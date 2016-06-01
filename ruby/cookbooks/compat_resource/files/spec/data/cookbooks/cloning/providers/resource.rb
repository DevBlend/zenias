provides :resource

use_inline_resources

action :create do
  log "stuff" do
    only_if { true }
  end
end
