-- Below is forth code to parse HTML, JS, CSS, and PHP into the browser.

: parse-html ( addr len -- )
  dup 0= if drop exit then
  dup html-tag-start? if
    ( addr len -- )
    swap
    html-tag-name ( addr len -- addr len )
    dup html-tag-end? if
      ( addr len -- addr len )
      drop
      html-tag-close ( addr len -- )
    else
      ( addr len -- addr len )
      html-attributes ( addr len -- addr len )
      html-content ( addr len -- )
      html-tag-open ( addr len -- )
    then
  else
    dup html-comment-start? if
      ( addr len -- )
      drop
      html-comment ( addr len -- )
    else
      ( addr len -- )
      html-text ( addr len -- )
    then
  then
;

: parse-js ( addr len -- )
  dup 0= if drop exit then
  js-token ( addr len -- )
  js-parse ( addr len -- )
;

: parse-css ( addr len -- )
  dup 0= if drop exit then
  css-token ( addr len -- )
  css-parse ( addr len -- )
;

: parse-php ( addr len -- )
  dup 0= if drop exit then
  php-token ( addr len -- )
  php-parse ( addr len -- )
;

: parse-document ( addr len -- )
  dup 0= if drop exit then
  ( addr len -- )
  dup html-doctype? if
    ( addr len -- )
    drop
    html-doctype ( addr len -- )
  else
    ( addr len -- )
    html-head ( addr len -- )
    html-body ( addr len -- )
  then
;

: load-page ( url -- )
  http-get ( url -- addr len )
  dup 0= if drop exit then
  ( addr len -- )
  parse-document ( addr len -- )
;
