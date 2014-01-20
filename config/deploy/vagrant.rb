set :stage, :production

server 'tg-vagrant', roles: %w{app web db}

set :log_level, :debug