flavor="dev"

fvm flutter clean
fvm flutter build apk --flavor $flavor -t lib/main_"$flavor".dart