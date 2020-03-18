- C:\iot>mongoexport -d mydb -c score -o score.json

- C:\iot>mongoimport /d bigdata /c test /type csv /file test.csv /headerline

  d: database, c: collection, type: 파일타입, headerline: 헤더라인 첫째줄 무시

  (로컬이 아닌 경우 host와 port 입력)