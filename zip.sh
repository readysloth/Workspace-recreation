if   [ $1 == "zip" ]; then
     [ -d "downloaded" ] && zip -r downloaded.zip downloaded/
elif [ $1 == "unzip" ]; then
     [ -e "downloaded.zip" ] && unzip downloaded.zip
fi
