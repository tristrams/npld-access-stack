# 
# Use only relative redirects, so upstream proxies can function without needing complex configuration:
# 

absolute_redirect off;

#
# Common redirects to support the original URLs, included in other configs:
#

location /welcome.html {
    # Also need 'npld_access_staff_autostart.html?' ?

    # Strip the matched path, converting the query string to be the path:
    set $new_path $args;
    set $args '';
    rewrite ^/(.*)$ /$new_path last;
}

location / {
    # Explicit ARKs
    rewrite ^/ark:/(\d+)/([^\/]+) /en/doc/20130401000000/http://doc-streamer:8000/ark:/$1/$2/ permanent;
    
    # Implied ARKs (starting with e.g. vdc_ or tvdc_ for IRC)
    rewrite ^/(vd[^\/]+) /en/doc/20130401000000/http://doc-streamer:8000/ark:/81055/$1/ permanent;
    rewrite ^/(tvd[^\/]+) /en/doc/20130401000000/http://doc-streamer:8000/ark:/81055/$1/ permanent;

    # UKWA IDs e.g. TIMESTAMP/URL:
    rewrite ^/(\d+)/(.*)$ /en/web/$1/$2 permanent;

    # Add a index page for internal use:
    root   /var/www/nginx-default;
    index  index.html index.htm;
}