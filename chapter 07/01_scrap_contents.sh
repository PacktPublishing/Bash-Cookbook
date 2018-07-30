$ mkdir -p data
$ cd data
$ wget -q -r -l5 -x 5  https://imdb.com
$ cd ..
$ grep -r -Po -h '(?<=href=")[^"]*' data/ > links.csv
$ grep "^http" links.csv > links_filtered.csv
$ sort -u links_filtered.csv > links_final.csv
$ rm -rf data links.csv links_filtered.csv
