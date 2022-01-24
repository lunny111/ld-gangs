resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

client_scripts {
    '@es_extended/locale.lua',
    'client.lua',
    'config.lua',
    'locales/tr.lua',
    'locales/en.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'server.lua',
    'config.lua',
    'locales/tr.lua',
    'locales/en.lua'
}