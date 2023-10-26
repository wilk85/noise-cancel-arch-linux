if you are getting an error when starting service pipewire-input-filter-chain.service
update variable $USER with your username and reaply commands

 systemctl --user daemon-reload
 systemctl --user enable pipewire-input-filter-chain.service
