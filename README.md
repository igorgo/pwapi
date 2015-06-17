# pwapi (апи вебинаров )
## Пути
- html - `\var\www\parus-default\`
- war - `\var\lib\tomcat7\webapps\`
- переадресовка - `ngnix \etc\bigbluebutton\nginx\parusapi.nginx`

## Записи
- список `sudo bbb-record --list`
- публикация
```bash
cd /usr/local/bigbluebutton/core/scripts/
sudo ./rap-worker.rb
```

Записи будут доступны по ссылке, где ... id из команды list
http://xx.xx.xx.xx/playback/presentation/0.9.0/playback.html?meetingId=...
